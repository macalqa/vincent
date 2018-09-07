#include "sliding.h"
/*  Slide all values of array up
*/
void slide_up(int* my_array, int rows, int cols)
{
	int i,j;
	int tempi;
	int val;
	for(j=0; j<cols; j++)
	{
		for(i=0; i<rows; i++)
		{
			if (( my_array[i*cols + j] != -1) && (i != 0 ))
			{
				val = my_array[i*cols + j];
				for(tempi=0; tempi<rows ; tempi++)
				{
					if ((my_array[tempi*cols +j] == -1) && (tempi < i))
					{
						my_array[tempi*cols + j] = val;
						my_array[i*cols +j] = -1;						
						tempi = rows;
					}
				}
			}
		}
	}
	return;
}
