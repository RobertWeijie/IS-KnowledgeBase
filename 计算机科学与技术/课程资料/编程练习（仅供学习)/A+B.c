#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);  // 输入数据组数

    while (n--) {
        int a, b;
        scanf("%d%d", &a, &b)!=EOF;  // 输入两个整数
        
        printf("%d\n", a + b);
    }

    return 0;
}


