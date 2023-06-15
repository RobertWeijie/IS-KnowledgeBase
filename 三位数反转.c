#include <stdio.h>

int main() {
    int num, ones, tens, hundreds;

    while (scanf("%d", &num) != EOF) {
        ones = num % 10;
        tens = (num / 10) % 10;
        hundreds = num / 100;

        
        

        int reversed_num = ones * 100 + tens * 10 + hundreds;
        printf("%d\n", reversed_num);
    }

    return 0;
}