go复制数组用copy内置方法：`copy(dst, src)`

矩阵反转两种方法：
1. 第一行变成倒数第一列。依此类推，这样需要额外空间。
2. 先上下翻转，再沿着对角线反转，这样不需要额外空间。

```1. matrix[i][j] = matrix[len-1-i]; 2. matrix[i][j] = matrix[j][i] for j < i```

## go 排序

sort包的Sort方法或者Slice方法，其中Slice方法要提供一个返回bool值得less函数

## go 容器

### 切片复制（拷贝）

使用内置函数`copy()`可以将一个数组切片复制到另一个数组切片中，如果大小不一样，就会按照其中**较小**的那一数组切片元素个数进行复制。

语法：
```golang
copy(dst, src) int
```
目标切片必须分配过空间并且足够承载复制元素的个数，来源和目标的类型必须一致，返回值表示实际发生复制的元素个数

### 删除元素

```golang
a = a[1:] // 删除开头1个元素
a = a[N:] // 删除开头N个元素
// 不移动指针
a = append(a[:0], a[1:]...)
a = append(a[:0], a[N:]...)
// 使用copy
a = a[:copy(a, a[1:])]
a = a[:copy(a, a[N:])]
```

### map

清除可以使用`delete(map, key)`方法

### 列表list（重要）

是链表

初始化

```golang
import "container/list"
variable := list.New() // 方法1
var variable list.List // 方法2
```

**插入元素**
```golang
l := list.New()
l.PushBack("first")
l.PushFront(67)
```

插入函数的返回值提供一个`*list.Element`结构，记录了列表元素的值以及与其他节点之间的关系等信息。可以用这个结构进行快速删除。

**删除元素**

```golang
element := l.PushBack("fist")
l.InsertAfter("high", element)
l.InsertBefore("noon", element)
l.Remove(element)
```

**访问元素**

使用`Front()`函数获取头元素，遍历时可以调用`Next()`函数：

```golang
for i := l.Front(); i != nil; i = i.Next() {
    fmt.Println(e.Value)
}
```

interface{}要进行类型转换，使用方法`element.(type)`方式进行类型转换，为了防止panic异常，可以采用`data, ok = element.(type)`的形式。