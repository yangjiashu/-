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

### 文件操作

主要的结构：`os.File`

可用的包：`ioutil`

```golang
err := ioutil.WriteFile("文件名", data, 0644)
readContent, _ := ioutil.ReadFile("文件名")

file, _ := os.Create("文件名")
numOfBytes, _ := file.Write(srcByteArr)

file, _ := os.Open("文件名")
numOfBytes, _ := file.Read(dstByteArr)
```

### 链接数据库

```golang
var Db *sql.DB
Db, err := sql.Open("数据库种类（postgres）", "参数")
```

连接过后可以调用`Db.Query()`来获取查询结果。

limit关键词限制查询的条数，offset关键词表示跳过n条记录。

### CRUD实例

```golang
func init() { // 初始化数据库
	var err error
	Db, err = sql.Open("postgres", "user=gwp dbname=gwp password=646233 sslmode=disable")
	if err != nil {
		panic(err)
	}
}

// 获取多行记录
func Posts(limit int) (posts []Post, err error) { // 查询前n条记录
	rows, err := Db.Query("select id, content, author from posts limit $1", limit)
	if err != nil {
		return
	}
	for rows.Next() {
		post := Post{}
		err = rows.Scan(&post.Id, &post.Content, &post.Author)
		if err != nil {
			return
		}
		posts = append(posts, post)
	}
	rows.Close()
	return
}

// 获取单行记录
func GetPost(id int) (post Post, err error) {
	post = Post{}
	err = Db.QueryRow("select id, content, author from posts where id = "+
		"$1", id).Scan(&post.Id, &post.Content, &post.Author)
	return
}

// 新建一条记录
func (post *Post) Create() (err error) {
	statement := "insert into posts (content, author) values ($1, $2) returning id"
	stmt, err := Db.Prepare(statement)
	if err != nil {
		return
	}
	defer stmt.Close()
	err = stmt.QueryRow(post.Content, post.Author).Scan(&post.Id)
	return
}

// 更新一条记录
func (post *Post) Update() (err error) {
	_, err = Db.Exec("update posts set content = $s2, author = $3 where id = $1", post.Id, post.Content, post.Author)
	return
}

// 删除一条记录
func (post *Post) Delete() (err error) {
	_, err = Db.Exec("delete from posts where id = $1", post.Id)
	return
}
```

# 顺序编程

## 变量

### 变量声明

`var 名字 类型`, 类型可以是函数，可以块初始化。

```golang
var (
	v2 int
	v2 int
)
```

### 变量初始化

1. var 名字 类型 = 字面值
2. var 名字 = 字面值
3. 名字 := 字面值

使用:=时左边至少有一个是未声明过的变量，注意作用域，子作用于重新声明的和父作用于声明的不是同一个变量。

### 变量赋值

可多重赋值

### 匿名变量

多返回值时使用下划线`_`

## 常量

### 字面常量

字面常量是指程序中硬编码的常量（字面量）。

如-12是整形常量，3.12浮点型常量，还有复数常量，布尔常量，字符串常量。**这些都是无类型常量**并不对应基础类型中的任何一类。

这些字面常量可以赋值成任何可以转换到的类型。

### 常量定义

从var变成const。

和变量的区别

```golang
const Pi float64 = 3.14 // float64类型常量
const zero = 0.0 // 无类型浮点常量
const (
	size int64 = 1024
	eof = -1 // 无类型整型常量
)
```

常量定义可以限制类型，但是没必要，如果没有限制类型，那么和字面常量一样是无类型常量。常量定义右值可以是常量表达式(编译器就要知道结果)。

### 预定义常量

预定义的常量有：true, false, iota。

iota比较特殊，是个可以被编译器修改的常量：在每一个const关键字出现时被重置为0，然后在下一个const出现之前，每出现一次iota，其代表的数字会自动增加1。

注意，如果两个const的赋值语句表达式一样 可以省略后一个赋值表达式（语法糖）。

```golang
const (
	c0 = iota // iota = 0
	c1	// c1 = iota == 1
	c2  // c2 = iota == 2
)
```

### 枚举

一般可以用iota和const结合定义枚举，Go没有明确的枚举。大写字母开头的常量也可以被包外访问。

## 类型

### 布尔类型

布尔类型不支持自动转换和强制转换，只能复制为true和false，或者返回值为两者的表达式，所以不存在bool(a)这种表达。

### 整型

uint8完全等价于byte, int和uint的大小与平台相关。即int和int32不是同一种类型，也不能自动转换，需要强制转换。

```golang
var value2 int32
value1 := 64 // 自动推导为int类型
value2 = value1 // 编译出错
```

不同类型的整数不能直接比较，但是都可以和字面常量进行比较。

位运算：go的取反是^

### 浮点型

默认是float64

比较时尽量不要采用比较运算符，因为浮点数不稳定。替代方案：

```golang
import "math"
func IsEqual(f1, f2, p float64) bool {
	return math.Fdim(f1, f2) < p
}
```

### 复数类型

complex64 由两个float32组成

value := 3.2 + 12i // 是complex128

value3 := complex(3.2, 12) // 是complex128

通过内置函数real(z),imag(z)获取实部和虚部。

### 字符串

在go中，字符串是原生类型。可以直接取下标，表示第n个字节表示的字符。初始化后不能被修改。

遍历：1.字节数组遍历 2.unicode字符遍历。用Unicode字符遍历时，每个字符的类型是rune。

### 字符类型

go支持两种字符类型：byte和rune，byte是单个字节的值，rune表示单个unicode字符。go是utf-8编码，可以和unicode互相转换，byte表示的是utf8字节值。

### 数组

数组是值类型。所以赋值时将产生复制动作。

### 数组切片

切片数据结构可以抽象为三个属性：一个指向原生数组的指针；表示元素个数的变量；已分配存储空间的变量；

copy内置函数用于内容复制：`copy(dst, src)`

### map

delete(map,key)用于删除元素，如果key不存在则不做任何事。但如果map是nil则会抛出异常（panic）。

取值有两种，第一种value = map[key],如果没有则value是默认零值；第二种value, ok = map[key]更加清晰。只需关注ok。

### 流程控制
。。。

switch不用加break，如果要继续向下执行，家关键字fallthrough

## 函数

