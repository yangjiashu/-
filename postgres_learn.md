### 常用命令

初次安装完成会生成：

1. 默认一个名为postgres的数据库。
2. 一个名为postgres的数据库用户。
3. 一个名为postgres的linux系统用户。

**使用postgres用户，来生成其他用户和新数据库**

使用PostgreSQL控制台

先创建一个linux新用户

`sudo adduser dbuser`

然后，切换到postgres用户。

`sudo su - postgres`

登陆PostgreSQL控制台

`psql`

相当于用户postgres以同名数据库用户的身份，登陆数据库，这里不用输入密码。首先要做的事是使用`\password`命令，为postgres用户设置一个密码。

`\password postgres`

然后创建数据库用户dbuser，并设置密码。

`create user dbuser with password 'password';`

创建用户数据库，这里为exampledb，指定所有者为dbuser。同时要赋予其权限。

```sql
create database exampledb owner dbuser;
grant all privileges on database exampledb to dbuser;
```

最后使用`\q`命令退出控制台。


**登陆数据库**

`psql -U dbuser -d exampledb -h 127.0.0.1 -p 5432`

输入上面的命令后，系统会提示输入dbuser用户的密码。

简写：如果当前linux用户，同时也是postgresSQL用户，则可以省略用户名。如果PostgreSQL内部还存在与当前系统用户同名的数据库，则连数据库名也可以省略。

**控制台命令**

```
\h: 查看SQL命令的解释。
\?: 查看psql命令列表。
\l: 列出所有数据库。
\c [name]: 链接其他数据库。
\d: 列出所有table。
\d [name]: 列出某一张table。
\du: 列出所有用户。
\e: 打开文本编辑器。
\conninfo: 列出所有连接信息。
\q: 退出。
```

### Mysql

### window

在根目录下创建my.ini文件夹，输入

```
[client]
# 设置mysql客户端默认字符集
default-character-set=utf8
 
[mysqld]
# 设置3306端口
port = 3306
# 设置mysql的安装目录
basedir=C:\\web\\mysql-8.0.11
# 设置 mysql数据库的数据的存放目录，MySQL 8+ 不需要以下配置，系统自己生成即可，否则有可能报错
# datadir=C:\\web\\sqldata
# 允许最大连接数
max_connections=20
# 服务端使用的字符集默认为8比特编码的latin1字符集
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
```

初始化`mysqld --initialize --console`

复制初始密码

执行`mysqld install`

执行`net start mysql`

登陆`mysql -u root -p`

输入密码

更改密码

`ALTER user 'root'@'localhost' IDENTIFIED BY '你的密码';`