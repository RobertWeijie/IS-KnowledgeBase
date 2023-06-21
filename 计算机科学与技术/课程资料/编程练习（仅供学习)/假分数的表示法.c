#include <stdio.h>

// 求最大公约数
int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int main() {
    int T;
    scanf("%d", &T);
    while (T--) {
        int a, b, c, d;
        scanf("%d%d%d%d", &a, &b, &c, &d);
        // 分子分母同时乘以 b*d，避免分数的通分运算
        int e = a * d + b * c;
        int f = b * d;
        // 约分，先求最大公约数，再同时除以最大公约数
        int g = gcd(e, f);
        e /= g;
        f /= g;
        printf("%d %d\n", e, f);
    }
    return 0;
}

/*
题意简单点，就是两个分数的相加。用假分数的表示法来表示。

输入
第一行一个数T表示有T组数据。
接下来T组数据，每组数据都都只有一行，四个整数a,b,c,d(1<=a,b,c,d<=10000)。

输出
对于每组测试数据，输出两个整数,e,f表示a/b+c/d=e/f。注意要约分哦。

输入样例
2
1 3 1 6
1 2 1 2
输出样例
1 2
1 1
*/
