## 简单活动图

活动标签以冒号开始，分号结束

可以用`start`标签表示开始，`end`或`stop`标签表示结束。

## 条件语句

条件语句放在`if`，`endif`块之中，块内使用`then`和`else`来表示判断结果和执行活动。也可以用`elseif`设置多个分支。

```
if (条件1?) then(yes)
    :n条活动标签;
else (no)
    :n条活动标签;
endif
```

## 重复循环

可以用`repeat`和`repeat while`设置循环，相当于C系语言中的`do while`语句，另外，`backward`标签可以设置返回时的操作:`backward:this is activity label;`

另外`while endwhile`语句块也可以定义循环，分支的标签用is和括号表示：

```
while (检查文件) is (not empty)
    :读文件;
endwhile (empty)
:closefile;
```

## 并行操作

`fork, fork agin, end fork`

## 注释

浮动注释，块注释，注释位置，注释内容，斜体，加粗，分割线，代码

## 箭头

-> 文字;
-[]->带特效的箭头; (#red, dotted, dashed)

## 分组

```
partition 分组名 {
    内容
}

|泳道名|
内容
|#AntiqueWhite|泳道名2|
内容
```