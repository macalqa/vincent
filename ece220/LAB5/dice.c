//Function for generating three d6 rolls
#include <stdio.h>
#include <stdlib.h>
void roll_three(int* one, int* two, int* three)
{
       	 *one = rand() ;
	 if (*one >= 6)
	{
		*one = (*one % 6) + 1;
	}	
	*two = rand();
	if (*two >= 6)
	{
		*two = (*two % 6) + 1;
	}
	*three = rand();
	if (*three >= 6)
	{
		*three = (*three % 6) + 1;
	}
}
