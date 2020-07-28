# channel

创建channel `ch := make(chan int)`创建一个int型channel

channel是引用类型

channel支持close操作，`close(ch)`，对关闭的channel执行写入操作会导致panic异常，但是可以对关闭的channel执行读操作，接收已经放在channel里面的数据，如果channel空了，则读出一个零值数据

## 无缓冲channel

对无缓冲的channel，无论读还是写都会阻塞，直到另一端发生写或读，有时也被称为同步channel

channel是happens before机制，在唤醒阻塞的goroutine之前读出数据或写入数据

happens before是要保证先后顺序

可以用range遍历channel，直到写入方关闭channel，则range结束

用`val, ok := <-ch`可以检测channel是否被写入方关闭

`out chan<- int` 和 `in <-chan int`可以表示单向的channel

