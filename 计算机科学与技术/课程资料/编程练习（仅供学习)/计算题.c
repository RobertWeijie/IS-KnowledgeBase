#include <stdio.h>

int main() {
    int T;
    scanf("%d", &T);  // 输入数据组数
    
    while (T > 0) {//均不为0
        T--;
        int a, b, c, d, e, f, g, h;
        scanf("%d%d%d%d%d%d%d%d", &a, &b, &c, &d, &e, &f, &g, &h);  // 输入数据
        
        int result = a * c / b + (d * g * h) / (e * f);  // 根据你的计算逻辑得出结果
        
        printf("%d\n", result);  // 输出结果
    }
    
    return 0;
}

/*
输入
多组数据，第一行一个数T，表示有T组数据。(1<T<1000)
接下来T行，每行8个数a,b,c,d,e,f,g,h（0<=a,b,c,d,e,f,g,h<=999999999,b,e,f均不为0)表示一组数据。
保证a/bc、d/e/fg*h与最终结果均为整数且在int范围内。


1
6 2 3 9 3 1 6 2

输出：45

*/





