#include <stdio.h>

int main() {
    int n, x;
    
    // 循环读入两个整数 n 和 x，直到读取到文件结尾 如果返回值不等于2说明读取失败或已到达文件结尾，循环结束
    while (scanf("%d%d", &n, &x) == 2) {
        int cnt = 0;  // 用于记录符合条件的数的个数
        for (int i = 1; i <= n; i++) {
            // 如果 x 能被 i 整除，并且 x/i 不大于 n，那么说明 x/i 符合要求
            if (x % i == 0 && x / i <= n) {
                cnt++;  // 记录符合条件的数的个数
            }
        }
        printf("%d\n", cnt);  // 输出符合条件的数的个数
    }
    
    return 0;
}
//本质上是数学题，只要判断能否整除且倍数合理即可

/*
输入
输入多组数据
每组数据共一行，每行两个数字n，x（1<=n<=1e5,1<=x<=1e9）

输出:对于每组数据
输出一个数字：桌子上x的数目

输入样例
10 5
6 12
5 13
输出样例
2
4
0
*/


