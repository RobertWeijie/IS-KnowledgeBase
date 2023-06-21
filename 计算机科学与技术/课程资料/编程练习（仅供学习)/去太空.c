#include <stdio.h>
#include <math.h>

#define MAX_N 100

// 定义计算两个点之间距离的函数
double distance(int x1, int y1, int z1, int x2, int y2, int z2) {
    return sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2));
}

int main() {
    int x0, y0, z0, n, x[MAX_N], y[MAX_N], z[MAX_N], k;
    while (scanf("%d%d%d", &x0, &y0, &z0) == 3) {//// 不断读入 x0, y0, z0 和 n 的值
        scanf("%d", &n);//// 读入 n 个点的坐标
        for (int i = 0; i < n; i++) {
            scanf("%d%d%d", &x[i], &y[i], &z[i]);
        }
        scanf("%d", &k);//// 读入 k 的值

        int max_index = -1;
        double max_fuel = 0.0;// 对于每个点，计算出到达该点和返回起点所需的燃料，并记录最大的燃料和对应的点的下标
        for (int i = 0; i < n; i++) {
            double fuel = distance(x0, y0, z0, x[i], y[i], z[i]) + distance(x[i], y[i], z[i], x0, y0, z0);
            if (fuel > max_fuel) {
                max_fuel = fuel;
                max_index = i;
            }
        }

        printf("%d %.6f\n", max_index + 1, max_fuel * k);//// 输出最大燃料和对应的点的下标，并乘以 k 得到总的花费
    }
    return 0;
}

/*
假设地球的坐标是x0,y0,z0,jhljx总共访问了n个星球，n个星球的坐标为x,y,z。
每次访问他都从地球出发，然后访问一个星球，再返回地球。
接着再从地球出发，去访问下一个星球，再返回地球。。。。
在飞行过程中，飞船每飞行1光年需要耗油k升。
请问在这n次飞行中，飞船耗油最多的一次是哪一次，这次飞行消耗了多少油。 (假设飞船都能够到达星球，不考虑没油的情况)。

输入
输入多组数据。
每组数据共(n+3)行。第一行为地球的坐标x0,y0,z0。(x0,y0,z0均为整数，且-1000<=x0,y0,z0<=1000)
第二行为访问的星球个数n。(1<=n<=100)
下面从第三行到第(n+2)行为jhljx要访问的星球的坐标x,y,z。(x,y,z均为整数，且-1000<=x0,y0,z0<=1000)
第(n+3)行为飞船每飞行1光年消耗的油量k。(k为整数，且1<=k<=100)

输出
输出飞船在这n次旅行中，耗油最多的一次飞行和这次飞行消耗的油量，两个数之间用空格隔开，油量的结果保留6位小数。
如果有多次飞行都满足耗油量最大，请输出序号最少的那一次。

输入样例
0 0 0
1
1 1 1
1
输出样例
1 3.464102 
*/