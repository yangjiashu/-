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