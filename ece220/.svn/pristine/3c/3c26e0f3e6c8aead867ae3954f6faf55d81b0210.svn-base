#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define PI 3.1416f
int main()
{
 float pi = PI;
 int n,ω1,ω2;
 printf("Enter values for n,ω1,and ω2 in that order.");
 scanf("%d %d %d", &n , &ω1, &ω2);
 printf("%d %d %d\n", n , ω1, ω2);
 float x = 0;
 int i=0;
 float y;	
 while ((x >= 0) && (x <= pi) && (i < n ))
 		{	
 			x = (i * pi) / n ;
 			i++ ;
 			y = sin(ω1 * x) + 1/2 * (sin(ω2 * x))  ;
 			printf("(%f,%f)\n", x,y);
 			
 		}
 return 0;
}
