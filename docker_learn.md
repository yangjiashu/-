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

```
docker rm `docker ps -a -q`
```

-a标志表示列出所有容器，-q表示只需要返回容器的id而不需要其他的信息，并传给了docker rm命令

## 重新启动容器

`sudo docker start <container_name>`

## 附着到容器上

`sudo docker attach <container_name>`

## 开启MySQL容器

`docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 -d mysql`

-p 3306:3306表示容器服务的3306端口映射到宿主主机的3306端口，后面长的那句表示设置mysql服务root用户的密码

然后运行`docker exec -it mysql-test bash`就可以进入容器的bash了

这d 以通过命令`mysql -h localhost -u root -p`启动mysql客户端