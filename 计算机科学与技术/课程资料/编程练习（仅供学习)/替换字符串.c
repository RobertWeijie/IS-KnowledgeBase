#include <stdio.h>

void fun(char s[], char c)
{
    int i, k = 0;
    for (i = 0; s[i] != '\0'; i++) {
        if (s[i] != c) {
            s[k++] = s[i];
        }
    }
    s[k] = '\0'; // 添加字符串结束标记
}

int main()
{
    char str[] = "hello world";
    fun(str, 'l');
    printf("%s\n", str); // 输出 "heo word"
    return 0;
}