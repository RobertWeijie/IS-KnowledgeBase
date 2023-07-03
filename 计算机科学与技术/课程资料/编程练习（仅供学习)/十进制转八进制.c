#include <stdio.h>
#include <stdlib.h>

struct Stack {
    int *p; // 元素基址 
    int *top; // 栈顶位置 
    int size;
    int inc; // 扩容 
};

void InitStack(struct Stack *h, int size1, int increment) { 
    h->p = (int*)malloc(size1 * sizeof(int));
    h->size = size1;
    h->top = h->p;
    h->inc = increment;
}

void Push(struct Stack *h, int z) { // 入栈 
    if (h->top == h->size + h->p) {
        h->p = (int*)realloc(h->p, (h->size + h->inc) * sizeof(int));
        h->size = h->size + h->inc; 
    }
    *(h->top) = z;
    h->top = h->top + 1;
}

int Pop(struct Stack *h) { // 出栈 
    int z = 0;
    if (h->top != h->p) {
        z = *(h->top - 1);
        h->top = h->top - 1;
    } else {
        printf("栈已空\n"); 
    }
    return z;
}

void decimalToOctal(int decimalNum) { // 十进制转八进制 
    int i, m2, k = 0;
    struct Stack m;
    InitStack(&m, 10, 10);
    for (i = 0; decimalNum >= 8; i++) {
        m2 = decimalNum % 8;
        Push(&m, m2);
        decimalNum = decimalNum / 8;
        k++;
    }
    if (decimalNum != 0) {
        Push(&m, decimalNum);
    }
    printf("转化后：");
    for (i = 0; i <= k; i++) {
        m2 = Pop(&m);
        printf("%d", m2);
    }
    printf("\n");
    free(m.p);
}
void decimalToBinary(int decimalNum) { // 十进制转八进制 
    int i, m2, k = 0;
    struct Stack m;
    InitStack(&m, 10, 10);
    for (i = 0; decimalNum >= 2; i++) {
        m2 = decimalNum % 2;
        Push(&m, m2);
        decimalNum = decimalNum / 2;
        k++;
    }
    if (decimalNum != 0) {
        Push(&m, decimalNum);
    }
    printf("转化后：");
    for (i = 0; i <= k; i++) {
        m2 = Pop(&m);
        printf("%d", m2);
    }
    printf("\n");
    free(m.p);
}


int main() {
    int decimalNum;
    printf("请输入一个十进制数：");
    scanf("%d", &decimalNum);
    decimalToOctal(decimalNum);
    decimalToBinary(decimalNum);
    return 0;
}