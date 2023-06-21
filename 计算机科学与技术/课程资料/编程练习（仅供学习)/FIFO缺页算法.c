#include "stdio.h"
#define N 15
#define M 4
int main()
{
	int a[N],i,j,q,b[M]={0},c[M][N],count=0;
	char flag,f[N];
	printf("请输入页面访问序列:\n");
	for(i=0;i<N;i++)                    
		scanf("%d",&a[i]);
	for(i=0;i<N;i++)                    //查页表，看是否缺页
	{  
		q=0;
		while((a[i]!=b[q])&&(q!=M))
		{
			q++;
		}		
 		if(q==M) 
		{
			flag='*';
			count++; 
		}//缺页，则置标志flag为'*'
		else flag=' ';
 		if(flag=='*')
 		{
			for(j=M-1;j>0;j--)              //淘汰最先调入的页面调入当前访问的
 				b[j]=b[j-1];
 				b[0]=a[i];
		//	printf("发生缺页的页面是：%3d\n",b[j]);
 		}
 		for(j=0;j<M;j++)               
 			c[j][i]=b[j];
 			f[i]=flag;
			if(c[j][3]==0)
			{
				printf(" ");
			}
			else
			{
				printf("被淘汰的页面是：%3d\n",c[j][3]);
			}
	 }
	 
	 printf("输出结果为下表（0代表为空，*代表有缺页）：\n");
	 printf("*********************************************************\n");
	 printf("页面走向：");//输出页面走向
	 for(i=0;i<N;i++)
		 printf("%3d",a[i]);
		 printf("\n");
	 printf("*********************************************************\n");
	 for(i=0;i<M;i++)//每块内的页面变化
	 {
		printf("   %d号块：",i);
		for(j=0;j<N;j++)
			printf("%3d",c[i][j]);
		printf("\n");
	 }
	 printf("*********************************************************\n");
	 printf("缺页情况：");
	 for(i=0;i<N;i++)//缺页的情况
		printf("%3c",f[i]);
	 printf("\n");
	 printf("*********************************************************\n");
     printf("\n发生缺页的次数=%d\n",count);
	 printf(" 缺页中断率=%.2f%%%\n",(float)count/N*100);
}

