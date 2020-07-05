### 第一步
1. 在github网站上创建一个库
2. 创建自己的本地库
3. 添加README.md文件：`echo "# [库名]" >> README.dm`
4. add和commit
5. remote：`git remote add origin https://github.com/yangjiashu/xxx.git`
6. push: `git push -u origin master`

具体过程如图1-1所示。
![使用git的第一步](./images/img1-1.png)

注意：在remote时，用命令git remote add xxxx(origin) xxxx(网址，ssh或者http)来挂载到远程仓库，如果是http方式，则要输入账号密码来push，如果是ssh，要在主机上生成ssh密钥，然后在github站点中设置信任密钥

到此为止，第一个git项目就与远程仓库链接成功了

### 拉取更新的项目

#### 命令

**1.查看远程仓库的情况**

`git remote -v`

**2.拉取远程仓库最新的代码**

`git fetch origin master:test`

从远程origin仓库拉取master分支，并在本地创建一个分支test，拉取到test分支。

**3.查看本地master和test分支的差异**

`git diff test`

这样就能看远程更新了哪些东西。

**4.合并本地master和test分支**

`git merge test`

