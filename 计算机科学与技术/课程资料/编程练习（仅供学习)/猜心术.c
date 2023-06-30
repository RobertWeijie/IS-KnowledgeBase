#include <stdio.h>

int main() {
    int nums[] = {1, 2, 3, 4, 5, 6, 7};
    int n, guess[4];
    int i, j, count = 0;

    printf("请记住以下7个数：\n");
    for (i = 0; i < 7; i++) {
        printf("%d ", nums[i]);
    }
    printf("\n");

    printf("请输入您心中想到的数：");
    scanf("%d", &n);

    for (i = 0; i < 4; i++) {
        printf("第%d个数是：", i+1);
        scanf("%d", &guess[i]);
    }

    for (i = 0; i < 4; i++) {
        if (guess[i] == n) {
            printf("1 ");
            count++;
        } else {
            printf("0 ");
        }
    }
    printf("\n");

    if (count == 0) {
        printf("您没有猜中数字。\n");
    } else {
        printf("您猜中了%d个数字，其中您心中想到的数字是：", count);
        for (i = 0; i < 4; i++) {
            if (guess[i] == n) {
                printf("%d ", guess[i]);
            }
        }
        printf("\n");
    }

    return 0;
}