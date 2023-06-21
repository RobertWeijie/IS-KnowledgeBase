#include <stdio.h>
int try(int );
int main()
{
int x;
x = try(5);
printf("%d\n",x);
return 0;
}
int try(int n)
{
if(n>0)
return ( n*try(n-2));
else
return (1);
}
