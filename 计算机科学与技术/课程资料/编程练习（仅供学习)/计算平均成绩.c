#include <stdio.h>

int main() {
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c);  // 输入三个同学的成绩

    // 计算平均成绩并输出结果
    double avg = (a + b + c) / 3.0;
    printf("%.2lf\n", avg);

    return 0;
}


