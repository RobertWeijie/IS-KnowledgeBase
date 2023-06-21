#include <stdio.h>

int main() {
    int num, ones, tens, hundreds;

    while (scanf("%d", &num) != EOF) {//这个是为了可以一直输入
        ones = num % 10;
        tens = (num / 10) % 10;
        hundreds = num / 100;

        
        

        int reversed_num = ones * 100 + tens * 10 + hundreds;
        printf("%d\n", reversed_num);
    }

    return 0;
}

/*
输入
多组数据，每组数据一行，一个𝑥
（100≤𝑥≤999
）。

输出
对每组输入数据输出一行，为反转后的数字（不带前导零）。

输入样例
127
742
640

输出样例
721
247
46
*/


