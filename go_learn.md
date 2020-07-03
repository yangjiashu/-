go复制数组用copy内置方法：`copy(dst, src)`

矩阵反转两种方法：
1. 第一行变成倒数第一列。依此类推，这样需要额外空间。
2. 先上下翻转，再沿着对角线反转，这样不需要额外空间。

```1. matrix[i][j] = matrix[len-1-i]; 2. matrix[i][j] = matrix[j][i] for j < i```