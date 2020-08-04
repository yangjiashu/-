# 安装vim插件和vimplug

下载plug.vim文件，放到vim根目录下的autoload文件中。

配置文件为用户目录下的.vimrc文件。

vim快捷键：

## 搜索

`/word`加n或N、`?word`加n或N

或者用`*`移动到下一个匹配的单词或者`#`移动到上一个匹配的单词

## 打开另一个文件

`:e filename`

## 块

先行选择，然后输入J可以全部连成一行，用<>可以自动缩进，或者tab和shift+tab。输入=号可以自动缩进。

先ctrl+v选择，移动到行尾，然后输入A可以在所有的段落后面加东西，或者在某个特定的地方输入i或I可以在后面或者前面插入内容。

## 分屏

:sp file 或者 :vs file

## 切换tab

`:tabc`：关闭当前tab
`:tabo`：关闭所有其他的tab
`gt, gT`：可以直接切换
`alt+n`：可以快速切换