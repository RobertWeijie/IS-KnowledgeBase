#include <stdio.h>

int main()
{
	const int amount=100;
	int price =100;
	printf("请输入你的金额");
	scanf("%d",&price);
	
	int change=amount-price;
	printf("找您%d\n",change);
	return 0;
}
	