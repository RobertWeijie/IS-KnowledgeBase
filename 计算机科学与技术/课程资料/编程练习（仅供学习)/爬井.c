#include <stdio.h>

int main() {
    // 定义变量n、a、b、c、d
    int n, a, b, c, d;
    // 读入n的值
    scanf("%d", &n);
    // 循环n次
    while (n--) {
        // 读入a、b、c、d的值
        scanf("%d%d%d%d", &a, &b, &c, &d);
        // 初始化时间和高度
        int time = 0;
        double height = 0.0;
        // 当高度小于a时循环
        while (height < a) {
            // 时间加一
            time++;
            // 高度增加b
            height += b;
            // 如果高度达到或超过a，则跳出循环
            if (height >= a) {
                break;
            }
            // 高度减少c
            height -= c;
            // 如果高度小于等于0，则高度为0，跳出循环
            if (height <= 0) {
                height = 0;
                break;
            }
            // 如果高度减去c后小于d，则高度为d
            if (height - c < d) {
                height = d;
            }
        }
        // 如果高度达到或超过a，则输出时间，否则输出"fail"
        if (height >= a) {
            printf("%d\n", time);
        } else {
            printf("fail\n");
        }
    }
    // 返回0，表示程序正常结束
    return 0;
}/*
题目描述
柯南在追捕犯人的时候掉入了没有井盖的深井，万幸他有阿笠博士发明的吸盘，但吸盘在掉下来的时候摔坏了，他每个小时能爬上一段距离。但在他休息的一瞬间中会滑下一段距离，幸运的是每隔一段距离有凹槽(自下而上)可以让柯南停止下滑，柯南需要编写代码来判断在自己能否爬出深井以及需要的时间，于是柯南开始敲代码。

输入
n组测试数据。
第一行为一个整数n,表示组数
第二行为一个整数a，表示井的深度。
第三行为一个整数b，表示柯南每小时爬的距离。
第四行为一个整数c，表示柯南每小时滑下的距离。
第五行为一个整数d，表示隔多少米有凹槽。
n,a,b,c,d均小于3000。

输出
每行输出一个结果。
若不能爬出深井，则输出"fail",
若能爬出深井，则输出爬出深井需要的时间。

输入样例
3  
600 131 25 50
500 131 25 50
300 100 118 120
输出样例
6
5
fail
*/
