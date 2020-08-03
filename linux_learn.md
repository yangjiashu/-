linux终止进程的命令

`kill -s 9 pid`，-s 9表示强行终止的意思。

## 查看端口

netstat命令：
* `-t`: 指明显示TCP端口
* `-u`: 指明显示UDP端口
* `-l`: 仅显示监听套接字
* `-p`: 显示进程标识符和程序名称，每个套接字/端口都属于一个程序
* `-n`: 不进行DNS轮询，显示IP（可加速操作）

例如

`netstat -ntlp` 查看所有tcp端口

`netstat -ntulp | grep 80` 查看所有80端口使用情况

`netstat -an | grep 3306` 查看所有3306端口使用情况

**一般情况**

`netstat -nlp`或详细的`netstat -nlpa`

之后可以终止进程或者`top`监控进程，`ps -aux`查看进程