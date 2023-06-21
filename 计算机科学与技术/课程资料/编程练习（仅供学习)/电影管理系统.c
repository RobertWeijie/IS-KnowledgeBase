#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_MOVIES 100
#define MAX_NAME_LENGTH 20
#define MAX_NUM_LENGTH 10
#define MAX_PHONE_LENGTH 20

struct movie
{
    char rate[MAX_NAME_LENGTH];    // 电影级别
    char name[MAX_NAME_LENGTH];    // 电影名称
    int time_hour;                 // 放映时间：小时
    int time_min;                  // 放映时间：分钟
    int seat;                      // 座位总数
    int sell;                      // 已售座位数
    char num[MAX_NUM_LENGTH];      // 票号
    char phone[MAX_PHONE_LENGTH];  // 手机号
    int* seat_num;                 // 座位号
};

struct movie movies[MAX_MOVIES];
int num_movies = 0;

void buy_ticket()
{
    char s[MAX_NAME_LENGTH], num[MAX_NUM_LENGTH], phone[MAX_PHONE_LENGTH];
    int i, a, j, k, flag = 0;
    time_t t;
    struct tm* ptr;
    time(&t);
    ptr = localtime(&t);
    printf("请输入你要观看的电影名称：");
    scanf("%s", s);
    for (i = 0; i < num_movies; i++) {
        if (strcmp(movies[i].name, s) == 0) {
            printf("您想要观看的电影信息如下：\n");
            printf("%s %s %d:%d %d %d\n", movies[i].rate, movies[i].name, movies[i].time_hour, movies[i].time_min,
                   movies[i].seat, movies[i].sell);
            if (movies[i].time_hour * 60 + movies[i].time_min > ptr->tm_hour * 60 + ptr->tm_min) {
                printf("请输入你要购买的票数：");
                scanf("%d", &a);
                if (a > movies[i].seat - movies[i].sell) {
                    printf("余票不足，请重新选择\n");
                    break;
                }
                movies[i].sell += a;
                for (j = 0; j < a; j++) {
                    printf("请输入第 %d 张票的票号：", j + 1);
                    scanf("%s", num);
                    printf("请输入第 %d 张票的手机号：", j + 1);
                    scanf("%s", phone);
                    k = rand() % (movies[i].seat - movies[i].sell + 1) + 1;
                    movies[i].seat_num[j] = k;
                    strcpy(movies[i].num, num);
                    strcpy(movies[i].phone, phone);
                    printf("购票成功！\n电影：%s\n票号：%s\n手机号：%s\n座位号：%d\n", movies[i].name, num, phone, k);
                  fflush(stdout);
                }
                flag = 1;
                break;
            } else {
                printf("此电影在今日 %d:%d 已经开始播放，已经无票\n", movies[i].time_hour, movies[i].time_min);
                break;
            }
        }
    }
    if (flag == 0) {
        printf("输入的电影名称错误或无此电影信息\n");
    }
}

void quit_ticket()
{
    char s[MAX_NAME_LENGTH], num[MAX_NUM_LENGTH], phone[MAX_PHONE_LENGTH];
    int i, m, j, flag = 0;
    printf("请输入你要退票电影名称：");
    scanf("%s", s);
    printf("请输入你要退票的数目：");
    scanf("%d", &m);
    for (i = 0; i < num_movies; i++) {
        if (strcmp(movies[i].name, s) == 0) {
            for (j = 0; j < movies[i].sell; j++) {
                printf("请输入第 %d 张票的票号：", j + 1);
                scanf("%s", num);
                printf("请输入第 %d 张票的手机号：", j + 1);
                scanf("%s", phone);
                if (strcmp(movies[i].num, num) == 0 && strcmp(movies[i].phone, phone) == 0) {
                    flag = 1;
                    break;
                }
            }
            if(flag == 0 || m > movies[i].sell) {
                printf("退票失败！输入的票号或手机号错误，或者退票数目大于已售票数\n");
            } else {
                movies[i].seat += m;
                movies[i].sell -= m;
                printf("退票成功！\n");
                printf("退票后的电影信息如下：\n");
                printf("%s %s %d:%d %d %d\n", movies[i].rate, movies[i].name, movies[i].time_hour, movies[i].time_min,
                       movies[i].seat, movies[i].sell);
            }
            break;
        }
    }
    if (i == num_movies) {
        printf("输入的电影名称错误或无此电影信息\n");
    }
}

int main()
{
    int choice;
    int i, j;
    for (i = 0; i < MAX_MOVIES; i++) {
        movies[i].seat_num = (int*)malloc(movies[i].seat * sizeof(int));
    }
    while (1) {
        printf("欢迎使用电影售票系统\n");
        printf("请选择操作：\n");
        printf("1. 添加电影\n");
        printf("2. 删除电影\n");
        printf("3. 查询电影\n");
        printf("4. 购买电影票\n");
        printf("5. 退票\n");
        printf("6. 退出系统\n");
        scanf("%d", &choice);
        switch (choice) {
            case 1:
                if (num_movies == MAX_MOVIES) {
                    printf("电影库已满，无法添加\n");
                    break;
                }
                printf("请输入电影级别：");
                scanf("%s", movies[num_movies].rate);
                printf("请输入电影名称：");
                scanf("%s", movies[num_movies].name);
                printf("请输入放映时间（小时 分钟）：");
                scanf("%d %d", &movies[num_movies].time_hour, &movies[num_movies].time_min);
                printf("请输入座位总数：");
                scanf("%d", &movies[num_movies].seat);
                movies[num_movies].sell = 0;
                printf("添加成功！\n");
                num_movies++;
                break;
            case 2:
                printf("请输入要删除的电影名称：");
                char del_name[MAX_NAME_LENGTH];
                scanf("%s", del_name);
                for (i = 0; i < num_movies; i++) {
                    if (strcmp(movies[i].name, del_name) == 0) {
                        for (j = i; j < num_movies - 1; j++) {
                            movies[j] = movies[j + 1];
                        }
                        num_movies--;
                        printf("删除成功！\n");
                        break;
                    }
                }
                if (i == num_movies) {
                    printf("未找到要删除的电影\n");
                }
                break;
            case 3:
                printf("请输入要查询的电影名称：");
                char query_name[MAX_NAME_LENGTH];
                scanf("%s", query_name);
                for (i = 0; i < num_movies; i++) {
                    if (strcmp(movies[i].name, query_name) == 0) {
                        printf("%s %s %d:%d %d %d\n", movies[i].rate, movies[i].name, movies[i].time_hour,
                               movies[i].time_min, movies[i].seat, movies[i].sell);
                        break;
                    }
                }
                if (i == num_movies) {
                    printf("未找到要查询的电影\n");
                }
                break;
            case 4:
                buy_ticket();
                break;
            case 5:
                quit_ticket();
                break;
            case 6:
                printf("谢谢使用，再见！\n");
                for (i = 0; i < num_movies; i++) {
                    free(movies[i].seat_num);
                }
                return 0;
            default:
                printf("输入错误，请重新输入\n");
                break;
        }
    }
}

