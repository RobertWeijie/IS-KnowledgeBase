#include <stdio.h>
#include <stdlib.h>

// 定义链表节点结构体
typedef struct Node {
    int data;
    struct Node *next;
} Node;

// 定义链表队列结构体
typedef struct LinkQueue {
    Node *front; // 队头指针
    Node *rear;  // 队尾指针
} LinkQueue;

// 初始化链表队列
void Init_LinkQueue(LinkQueue *Q) {
    Q->front = Q->rear = NULL;
}

// 判断链表队列是否为空
int IsEmpty_LinkQueue(LinkQueue Q) {
    return Q.front == NULL;
}

// 入队操作
int Insert_LinkQueue(LinkQueue *Q, int e) {
    // 创建新节点
    Node *p = (Node *) malloc(sizeof(Node));
    if (p == NULL) {
        return 0; // 内存分配失败，返回0表示失败
    }
    p->data = e;
    p->next = NULL;

    // 队列为空的情况
    if (Q->rear == NULL) {
        Q->front = Q->rear = p;
    } else {
        Q->rear->next = p;
        Q->rear = p;
    }

    return 1; // 入队成功，返回1表示成功
}

// 出队操作
int Delete_LinkQueue(LinkQueue *Q, int *x) {
    if (IsEmpty_LinkQueue(*Q)) {
        return 0; // 队列为空，返回0表示失败
    }

    Node *p = Q->front;
    *x = p->data;
    Q->front = p->next;
    free(p);

    // 队列已经空了
    if (Q->front == NULL) {
        Q->rear = NULL;
    }

    return 1; // 出队成功，返回1表示成功
}

// 测试函数
int main() {
    LinkQueue Q;
    Init_LinkQueue(&Q);

    // 入队测试
    Insert_LinkQueue(&Q, 1);
    Insert_LinkQueue(&Q, 2);
    Insert_LinkQueue(&Q, 3);

    // 出队测试
    int x;
    while (Delete_LinkQueue(&Q, &x)) {
        printf("%d ", x);
    }

    return 0;
}