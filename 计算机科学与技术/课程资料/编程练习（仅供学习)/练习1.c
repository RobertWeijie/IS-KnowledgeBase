#include <stdio.h>
int func(int n)
{
	if(n<=1)
		return 1;
	else
		return (2+n*func(n-1));
}
int main()
{
	int x=4;
	printf("%d\n",func(x));
	return 0;
}