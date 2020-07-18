# 本地

## 版本回退

查看版本输入命令：`git log`或者简短版`git log --pretty=oneline`

查看所有命令的历史：`git reflog`

版本回退：HEAD指针指向当前版本，命令行最上面的是当前的版本HEAD,上一个版本表示为HEAD^,以此类推。要回退到某个特定的版本命令是：

`git reset --hard [版本id或者HEAD^^^]`

## 工作区和暂存区

![git组成](./images/git.PNG)

