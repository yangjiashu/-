### 安装Docker

在centOS中需要添加EPEL软件包的仓库。

然后执行命令`yum -y install docker-io`

## Docker守护进程

Docker以root权限运行它的守护进程，来处理普通用户无法完成的操作（如挂载文件系统）。docker程序是Docker守护进程的客户端程序，同样也需要以root身份运行。

守护进程监听/var/run/docker.sock这个Unix套接字文件以获取来自客户端的请求。

可以用-H标志调整守护进程绑定监听接口的方式。

## 运行第一个容器

`sudo docker run -i -t ubuntu /bin/bash

-i标志保证容器中STDIN是开启的。持久的标准输入是交互式shell的半边天，-t标志告诉Docker为要创建的容器分配一个伪tty终端。这样，新创建的容器才能提供一个交互式shell。如果要创建一个我们能与之进行交互的容器，这两个参数是最基本的参数。另外，当容器创建完毕后，会执行**容器中**的/bin/bash命令。

`docker help run`可以查看命令的帮助信息

在docker容器中，通常是linux系统，输入`hostname`命令可以输出主机名，输入`hostname -I`可以查看简洁的信息

`cat /etc/hosts`命令可以可以查看hosts文件,可以查看到docker在hosts文件中为该容器的IP地址添加了一条主机配置项。

这时，可以输入命令`ip a`查看网络配置,刚安装的linux系统只包含最简单的功能，要使用该命令，要先安装额外的软件，执行`apt update`和`apt install -y iproute2`

`ps -aux`可以查看进程

## 生命周期

只有在指定的/bin/bash命令处于运行状态时，容器才相应的处于运行状态，也就是说，如果输入`exit`命令退出bash，那么容器也会停止运行，但是容器依然是存在的，可以用`docker ps -a`命令查看当前系统中容器的列表

默认情况下`docker ps`命令只能看到正在运行的容器，`docker ps -l`可以列出最后一个运行的容器，不管是正在运行还是已经停止的

## 容器命名

使用命令`sudo docker run --name container_name -i -t ubuntu /bin/bash`来为容器指定名称。这样在很多的命令中就可以用名称来代替容器ID

## 删除容器

在运行中的容器不能直接删除，要先通过`docker stop`或者`docker kill`命令停止容器，才能将其删除

删除的命令是`docker rm`，要删除所有容器命令为

`docker rm -f` 可以强制删除正在运行的容器

```
docker rm `docker ps -a -q`
```

`docker container prune`可以清理掉所有处于终止状态的容器

-a标志表示列出所有容器，-q表示只需要返回容器的id而不需要其他的信息，并传给了docker rm命令

## 重新启动容器

`sudo docker start <container_name>`

## 附着到容器上

`sudo docker attach <container_name>`

## 开启MySQL容器

`docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql`

-p 127.0.0.1:3306:3306表示宿主主机3306端口映射到容器服务的3306端口，后面长的那句表示设置mysql服务root用户的密码, 如果是大写的-P，则表示容器内部的端口随机映射到主机上

然后运行`docker exec -it mysql-test bash`就可以进入容器的bash了

这d 以通过命令`mysql -h localhost -u root -p`启动mysql客户端

## 查看容器内的进程

`docker top <id/name>`

## 在容器内部运行进程

`docker exec -it <id/name> <程序名>`

## 查看容器

`docker ps`, `docker ps -a`, `docker ps -l`, `docker ps -n <数字>`显示最后n个，无论运行或没运行

`docker inspect <id/name>` 很多内容，非常详细

## 自动重启

`docker run --restart=always --name <name> -d <imgname>` 

--restart还可以设置为on-failure，这样，只有当退出代码非0时才重启，还可以设置重启次数

`--restart=on-failure:5`

## 构建镜像

* 使用 `docker commit`  命令
* 使用 `docker build` 命令和`Dockerfile`文件（推荐）

`docker commit -m "注释" --author="myname" <name/id> xxx/xxx:latest`

* `-a`: 作者
* `-m`: 提交备注

最后两个参数是**容器名**(源)和**镜像名**(目标)

```
// build 模式
mkdir static_web
touch Dockerfile
vim Dockerfile

# Version: 0.0.1
FROM ubuntu:14.0.0
MAINTAINER Jiashu Yang xxx@skld.com
RUN apt-get update
RUN apt-get install -y nginx
RUN echo 'Hi, I am in your container' > /usr/share/nginx/html/index.html
EXPOSE 80
```

`docker build -t ubuntu/python:latest .`

## 登陆docker

`docker login`

## 在容器中装东西

`apt-get -yqq update`   `apt-get -y install apache2`

## 导出和导入快照

* 导出 `docker export [name|id] > xxx.tar`
* 导入 `cat xxx.tar | docker import - [test/myubuntu(镜像名)]`

另外也可以从某个指定URL或目录来导入

## 查看端口映射

`docker port [容器名称]`

## 查看日志

`docker logs [容器名称]`可以查看容器的日志

当我们在本地主机使用一个不存在的镜像时Docker会自动下载这个镜像，如果我们想预先下载这个镜像，我们可以使用docker pull命令来下载它。

## 容器互联

端口映射并不是唯一把docker连接到另一个容器的方法，docker又一个连接系统允许将多个容器连接在一起，共享连接信息。docker连接回去创建一个父子关系，其中父容器可以看到子容器的信息。

新建docker网络

`docker network create -d bridge test-net`, -d指定网络类型，有bridge,overlay。其中overlay网络类型用于Swarm mode

通过命令`docker network ls`查看网络

运行一个容器并连接到新建的test-net网络

`docker run -itd --name test1 --network test-net ubuntu /bin/bash`

安装ping工具`apt-get update`, `apt install iputils-ping`，然后直接执行`ping test2`

如果有容器连接，建议使用docker-compose

## Dockfile

`FROM`: 定制的镜像都要基于FROM的镜像

`RUN`: 用于执行命令，有两种格式

* RUN <命令行命令> shell格式
* RUN ["可执行文件", "arg1", "arg2"] exec格式

Dockerfile的指令每执行一次都会在docker上新建一层。所以过多无意义的层，会造成镜像膨胀过大。可以用`&&`连接命令

`COPY`: 从上下文目录中（docker build时指定的上下文）复制文件或目录到容器里指定路径。

`ADD`: ADD和COPY使用格式一致，推荐用COPY，但是如果源文件是压缩文件的话，会自动解压到目标路径。

`CMD`: 类似于RUN指令，用于运行程序，但是二者的运行时间点不同

* CMD在docker run时运行。
* RUN在docker build时运行。

**作用**：为启动的容器指定要默认运行的程序，程序运行结束后，容器也就结束了，CMD指令指定的程序可被docker run命令行参数中指定要运行的程序所覆盖。如果Dockerfile中有多个CMD指令，则仅最后一个生效

`ENTRYPOINT`: 类似CMD，但是不会被docker run的命令行参数指定的指令所覆盖，而且这些参数会被当作参数传给ENTRYPOINT指令指定的程序，一般搭配CMD使用

```
ENTRYPOINT ["nginx", "-c"] # 定参
CMD ["/etc/nginx/nginx.conf"] # 变参
```

`ENV`: 设置环境变量, `ENV <key> <valuel>`, `ENV <key1>=<value1>`

`VOLUME`: 定义匿名数据卷。在启动容器时忘记挂在数据卷，会自动挂载到匿名卷。可以避免重要的数据，因容器重启而丢失；避免容器不断变大

`EXPOSE`: 仅仅只是声明端口

`WORKDIR`: 用WORKDIR指定的工作目录，会在构建镜像的每一层中都存在。