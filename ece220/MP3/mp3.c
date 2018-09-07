#include <stdio.h>
#include <stdlib.h>
#include <math.h>
//Micaela Bernichio
//mdb2
// This program calculates the numbers in the "nth" row of pascals triangle
// by taking the facotorials of the components and storing the result
// as an unsigned long.
int main()
{
  int row_index;

  printf("Enter the row index : ");
  scanf("%d",&row_index);

  // Your code starts from here
  int k=0;
  int n = row_index;
  unsigned long result=0;
  unsigned long i, j;
  double halfway = n/2;
  int flag = 0;

  if (n%2 == 0)
  {
    flag = 1;        // set a flag to indicate if n is even
  }


  for(k = 0; k<= halfway; k++)
  {
    int p = n-k;
    double top = 1;

      for(i = n; i > p; i--)
    {
        top = top * i;       // finds the factorial of the top if k = 0
    }

    double bottom = 1;

    for(j = 1; j <= k; j++)
    {
        bottom = bottom * j;  //find the factorial for the bottom
    }
        
    result = top/bottom;    //obtains the result from dividing the bottom from the top

    printf("%lu ", result); //print result
  }

  k--;                        //decrement k
   
  if (flag == 1)   
  {
    k--;                      // if n is even, decrement k a second time
  }


  while (k >= 0)            // while k>=0 find factorials of top and bottom
  {                            // result equals top divided by bottom
     int p = n-k;
        double top = 1;

        for(i = n; i > p; i--)
        {
                top = top * i;
        }

        double bottom = 1;
    
    for( j = 1; j <= k; j++)
    {
        bottom = bottom * j;
    }

    result = top/bottom;

        printf("%lu ", result);  // print result as long unsigned

    k--;                 //decrement k 
  }

  printf("\n");         
  return 0;
}

