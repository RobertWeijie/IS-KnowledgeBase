#include <stdio.h>

int main() {
    int n, m;
    while (scanf("%d %d", &n, &m) !=EOF) {
        int k = n / m;
        while (k > 0) {
            if (k * m <= n) {
                printf("%d %d\n", k, k * m);
                break;
            }
            k--;
            
        }
        //break;
    }
    return 0;
}
/*
给你了两个正整数n和m，其中n比m要大。jhljx要你计算出k*m的值，要求保证k*m小于等于n并且k值最大。

输入
输入多组数据。 每组数据两个正整数n和m（n和m在int范围内）。

输出
对于每组数据，输出k和k*m的值，两个数字之间用一个空格隔开。
*/
/*
输入：10 5
     10 3
输出： 2 10
      3 9
*/