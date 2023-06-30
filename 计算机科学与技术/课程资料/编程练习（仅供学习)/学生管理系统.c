#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_COURSES 3
#define MAX_STUDENTS 20
#define MAX_NAME_LENGTH 50

typedef struct {
    int id;
    char name[MAX_NAME_LENGTH];
    float scores[MAX_COURSES][3];  // 平时、实验、考试成绩
} Student;

void login(Student students[], int count) {
    int id;
    printf("请输入学生ID: ");
    scanf("%d", &id);

    for (int i = 0; i < count; i++) {
        if (students[i].id == id) {
            printf("登录成功！\n");
            printf("学生信息：\n");
            printf("ID: %d\n", students[i].id);
            printf("姓名: %s\n", students[i].name);
            printf("平时成绩: %.2f\n", students[i].scores[0][0]);
            printf("实验成绩: %.2f\n", students[i].scores[0][1]);
            printf("考试成绩: %.2f\n", students[i].scores[0][2]);
            return;
        }
    }

    printf("未找到该学生ID的记录。\n");
}

void modify(Student students[], int count) {
    int id;
    printf("请输入要修改成绩的学生ID: ");
    scanf("%d", &id);

    for (int i = 0; i < count; i++) {
        if (students[i].id == id) {
            printf("学生信息：\n");
            printf("ID: %d\n", students[i].id);
            printf("姓名: %s\n", students[i].name);
            printf("平时成绩: %.2f\n", students[i].scores[0][0]);
            printf("实验成绩: %.2f\n", students[i].scores[0][1]);
            printf("考试成绩: %.2f\n", students[i].scores[0][2]);

            printf("请输入新的平时成绩: ");
            scanf("%f", &students[i].scores[0][0]);
            printf("请输入新的实验成绩: ");
            scanf("%f", &students[i].scores[0][1]);
            printf("请输入新的考试成绩: ");
            scanf("%f", &students[i].scores[0][2]);

            printf("成绩修改成功！\n");
            return;
        }
    }

    printf("未找到该学生ID的记录。\n");
}

void search(Student students[], int count) {
    int id;
    printf("请输入要查找成绩的学生ID: ");
    scanf("%d", &id);

    for (int i = 0; i < count; i++) {
        if (students[i].id == id) {
            printf("学生信息：\n");
            printf("ID: %d\n", students[i].id);
            printf("姓名: %s\n", students[i].name);
            printf("平时成绩: %.2f\n", students[i].scores[0][0]);
           printf("实验成绩: %.2f\n", students[i].scores[0][1]);
            printf("考试成绩: %.2f\n", students[i].scores[0][2]);
            return;
        }
    }

    printf("未找到该学生ID的记录。\n");
}

void summarizeByStudent(Student students[], int count) {
    printf("按学生汇总成绩：\n");

    for (int i = 0; i < count; i++) {
        float totalScore = students[i].scores[0][0] + students[i].scores[0][1] + students[i].scores[0][2];
        printf("学生ID: %d\n", students[i].id);
        printf("姓名: %s\n", students[i].name);
        printf("总成绩: %.2f\n", totalScore);
        printf("\n");
    }
}

void summarizeByCourse(Student students[], int count) {
    printf("按课程汇总成绩：\n");

    float totalScores[MAX_COURSES] = {0};

    for (int i = 0; i < count; i++) {
        for (int j = 0; j < MAX_COURSES; j++) {
            totalScores[j] += students[i].scores[0][j];
        }
    }

    for (int i = 0; i < MAX_COURSES; i++) {
        printf("课程%d总成绩: %.2f\n", i + 1, totalScores[i]);
    }
}

void saveDataToFile(Student students[], int count) {
    FILE* file = fopen("grades.txt", "w");
    if (file == NULL) {
        printf("无法打开文件。\n");
        return;
    }

    for (int i = 0; i < count; i++) {
        fprintf(file, "%d %s %.2f %.2f %.2f\n", students[i].id, students[i].name, students[i].scores[0][0], students[i].scores[0][1], students[i].scores[0][2]);
    }

    fclose(file);

    printf("数据保存成功！\n");
}

int main() {
    Student students[MAX_STUDENTS];
    int studentCount = 0;

    // 从文件加载数据
    FILE* file = fopen("grades.txt", "r");
    if (file != NULL) {
        while (!feof(file) && studentCount < MAX_STUDENTS) {
            fscanf(file, "%d %s %f %f %f", &students[studentCount].id, students[studentCount].name,
                   &students[studentCount].scores[0][0], &students[studentCount].scores[0][1], &students[studentCount].scores[0][2]);
            studentCount++;
        }
        fclose(file);
        printf("数据加载成功！\n");
    }

    int choice;
    while (1) {
        printf("\n********** 学生成绩管理系统 **********\n");
        printf("1. 登录查看成绩\n");
        printf("2. 修改成绩\n");
        printf("3. 查找成绩\n");
        printf("4. 按学生汇总成绩\n");
        printf("5. 按课程汇总成绩\n");
        printf("6. 保存数据到文件\n");
                printf("0. 退出\n");
        printf("************************************\n");
        printf("请输入操作选项：");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                login(students, studentCount);
                break;
            case 2:
                modify(students, studentCount);
                break;
            case 3:
                search(students, studentCount);
                break;
            case 4:
                summarizeByStudent(students, studentCount);
                break;
            case 5:
                summarizeByCourse(students, studentCount);
                break;
            case 6:
                saveDataToFile(students, studentCount);
                break;
            case 0:
                printf("感谢使用！再见！\n");
                exit(0);
            default:
                printf("无效的选项，请重新输入。\n");
                break;
        }
    }

    return 0;
}


