#include <stdio.h>
#include <math.h>

int main() {
    int n;
    scanf("%d", &n);  // 输入刷 TD 的次数

    // 计算完成任务需要的天数并输出结果
    int days = ceil(n / 3.0);
    printf("%d\n", days);

    return 0;
}

/*
新版的TD每天可以刷3次哦O(∩∩)O
作为勤奋的Coolbreeze猪脚，可是一次都不肯落下呢。假设每学期要刷n次 TD，那么cool_breeze猪脚只需要多少天就可以完成任务呢输入共一组数据，每组一个数字n（1<=n<=1000）

*/


