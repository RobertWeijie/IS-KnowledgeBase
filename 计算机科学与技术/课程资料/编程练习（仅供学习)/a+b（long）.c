#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);  // 输入数据组数

        long int a, b;
        scanf("%ld%ld", &a, &b);  // 输入两个整数
        
        printf("%ld\n", a + b);
        
    return 0;
}

//不排除long的类型