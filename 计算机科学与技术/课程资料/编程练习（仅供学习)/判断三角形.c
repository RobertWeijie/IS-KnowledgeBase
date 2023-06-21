#include <stdio.h>

int main() {
    int a, b, c;

    while (scanf("%d %d %d", &a, &b, &c) == 3) {
        if (a + b <= c || a + c <= b || b + c <= a) {
            printf("wrong\n");
        } else if (a * a + b * b == c * c || a * a + c * c == b * b || b * b + c * c == a * a) {
            printf("good\n");
        } else if (a == b || b == c || a == c) {
            printf("perfect\n");
        } else {
            printf("just a triangle\n");
        }
    }

    return 0;
}

/*
如果是直角三角形输出“good”，等腰三角形输出perfect，如果不是三角形输出“wrong”
*/
