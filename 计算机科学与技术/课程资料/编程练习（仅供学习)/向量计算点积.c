#include <stdio.h>

int weishu(double* p)
{
    int flag = 1;
    int n;
    char c, d;
    for (n = 0; flag && scanf("%lf%c%c", p + n, &c, &d) == 3; n++)
    {
        if (c == ')') flag = 0;
    }
    return n;
}

int main()
{
    double a[20], b[20];
    int k = 1;
    double s, m;
    scanf("(");
    s = weishu(a);
    scanf(" (");
    m = weishu(b);
    while (s != 0 && m != 0) // 修改为while循环
    {
        printf("Case %d: ", k);
        k++;
        if (s != m)
        {
            printf("none\n");
        }
        else
        {
            double sum = 0; // 将sum的定义移入else语句块
            for (int i = 0; i < s; i++)
            {
                sum += a[i] * b[i];
            }
            printf("%.2lf\n", sum);
        }
        scanf(" (");
        s = weishu(a);
        scanf(" (");
        m = weishu(b);
    }
    return 0;
}