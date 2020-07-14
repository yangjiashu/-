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

