#include <stdio.h>
int main()
{
    int n, m, k;

    while(scanf("%d%d%d", &n, &m, &k) != EOF) { // 本行实现输入3个整数到变量n, m, k 
    
printf("%d\n",(2*n+m*k)*(k+1)/2);//2 天后吃糖数量为 1+2*1=3 块。总共吃糖的个数就是 1+2+3=6。总共吃了 3 天，而不是 2 天 k+1 代表3天
    }

    return 0;
}