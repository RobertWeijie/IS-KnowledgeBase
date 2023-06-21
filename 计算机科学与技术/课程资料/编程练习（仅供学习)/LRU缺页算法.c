#include "stdio.h"
#define n 15
#define m 4
int main()
{
	int a[n],i,j,q,b[m]={0},c[m][n],count=0;
	char flag,f[n];
	printf("请输入页面访问序列（输入十五个数后回车）:\n");
	for(i=0;i<n;i++)                    
	scanf("%d",&a[i]);
	printf("\n");
	for(i=0;i<n;i++)                    //查页表，看是否缺页
	{  
		q=0;
 		while((a[i]!=b[q])&&(q!=m)) q++; 
 		if(q==m) 
		{
			flag='*';
			count++; 
		}//缺页，则置标志flag为'*'
 		else flag=' ';
 		for(j=q;j>0;j--)
 			b[j]=b[j-1];
 			b[0]=a[i];
 		for(j=0;j<m;j++)
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
	printf("页面走向：");
	for(i=0;i<n;i++)
		 printf("%3d",a[i]);
		 printf("\n");
	printf("*********************************************************\n");
	for(i=0;i<m;i++)
	{
		printf("   %d号块：",i);
		for(j=0;j<n;j++)
		printf("%3d",c[i][j]);		
		printf("\n");
	}
	printf("*********************************************************\n");
	printf("缺页情况：");
	for(i=0;i<n;i++)
	printf("%3c",f[i]);
	printf("\n");
	printf("*********************************************************\n");
	printf("\n发生缺页的次数=%d\n",count);
	printf("缺页中断率=%.2f%%%\n",(float)count/n*100);
}	

