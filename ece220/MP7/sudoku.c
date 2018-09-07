#include "sudoku.h"

//-------------------------------------------------------------------------------------------------
// Start here to work on your MP7
//-------------------------------------------------------------------------------------------------
//
//
//Micaela Bernichio
//mdb2
//03-16-17
//
//
// You are free to declare any private functions if needed.

// Function: is_board_full
// I use this function in solve_sudoku to determine if the sudoku board is full of numbers-
// meaning the board is solved.
int is_board_full(int sudoku[9][9])
{
	int i,j;
	for (i=0; i<=8 ; i++)
	{
		for (j=0 ; j<=8 ; j++)
		{
			if (sudoku[i][j] == 0)
			{
				return 2;         //iterative process that goes through the cells until a 0 or "empty space" is found
			}
		}
	}
	
	return 1;                                 //if no empty spaces are found, then 1 is returned and the function is returned to main.

}
// Function: is_val_in_row
// // Return true if "val" already existed in ith row of array sudoku.
int is_val_in_row(const int val, const int i, const int sudoku[9][9])
{

  assert(i>=0 && i<9);
// BEG TODO
int rowj;

for ( rowj=0 ; rowj<9 ; rowj++ )
{
	if ( sudoku[i][rowj] == val )
	{
		return 1; 
	}
}                                        // checks to see if a number can be placed in a particular row--- checks to see if that number exists in same row
 
  return 0;

  // END TODO
}

// Function: is_val_in_col
// Return true if "val" already existed in jth column of array sudoku.
int is_val_in_col(const int val, const int j, const int sudoku[9][9])
{

  assert(j>=0 && j<9);

  // BEG TODO
 int coli;
 for ( coli=0 ; coli<9 ; coli++ )
{
	if ( sudoku[coli][j] == val )
	{
		return 1;
	}                             //check to see if a value can be placed in a particular column---
} 					//checks to see if that value exists in the same column
  return 0;
  // END TODO
}

// Function: is_val_in_3x3_zone
// Return true if val already existed in the 3x3 zone corresponding to (i, j)
// first determines which 3x3 "sector" the i and j lie in.
// once that is determined, it does a sweep to compare each cell in that 3x3 to the value to see if the number can be placed there.
int is_val_in_3x3_zone(const int val, const int i, const int j, const int sudoku[9][9]) 
{
   
  assert(i>=0 && i<9);
  
  // BEG TODO
int tempj;
int tempi;
if (i == 0 || i == 1 || i == 2)
{
	
	if ( j == 0 || j == 1 || j == 2)
	{
		 for ( tempi = 0 ; tempi <= 2 ; tempi++)
                {
                        for (tempj = 0 ; tempj <= 2 ; tempj++)
                        {
                                if (sudoku[tempi][tempj] == val)
                                {
                                        return 1;
                                }
                        }
                }

	}
	if ( j == 3 || j == 4 || j == 5)
	{
		for ( tempi = 0 ; tempi <= 2 ; tempi++)
                {
                        for (tempj = 3 ; tempj <= 5 ; tempj++)
                        {
                                if (sudoku[tempi][tempj] == val)
                                {
                                        return 1;
                                }
                        }
                }

	}
	if ( j == 6 || j == 7 || j == 8)
	{
		  for ( tempi = 0 ; tempi <= 2 ; tempi++)
                {
                        for (tempj = 6 ; tempj <= 8 ; tempj++)
                        {
                                if (sudoku[tempi][tempj] == val)
                                {
                                        return 1;
                                }
                        }
                }

	}
}  
if (i == 3 || i == 4 || i == 5)
{
	
        if ( j == 0 || j == 1 || j == 2)
        {
		for ( tempi = 3 ; tempi <= 5 ; tempi++ )
                {
                        for ( tempj= 0 ; tempj <= 2 ; tempj++)
                        {
                                if (sudoku[tempi][tempj] == val)
                                {
                                        return 1;
                                }
                        }
                }

		
	}
	if ( j == 3 || j == 4 || j == 5)
        {
               for ( tempi = 3 ; tempi <= 5 ; tempi++ )
                {
                        for ( tempj= 3 ; tempj <= 5 ; tempj++)
                        {
                                if (sudoku[tempi][tempj] == val)
                                {
                                        return 1;
                                }
                        }
                }

        }

	if ( j == 6 || j == 7 || j == 8)
        {
                for ( tempi = 3 ; tempi <= 5 ; tempi++ )
		{
			for ( tempj= 6 ; tempj <= 8 ; tempj++)
			{
				if (sudoku[tempi][tempj] == val)
				{
					return 1;
				}
			}
		}
        }

}

if (i == 6 || i == 7 || i == 8)
{   	
	
        if ( j == 0 || j == 1 || j == 2)
        {
		for ( tempi = 6 ; tempi <= 8 ; tempi++)
		{
			for (tempj = 0 ; tempj <= 2 ; tempj++)
			{
				if (sudoku[tempi][tempj] == val)
				{
					return 1;
				}
			}
		}
             
        }

	if ( j == 3 || j == 4 || j == 5)
        {
                for ( tempi = 6 ; tempi <= 8 ; tempi++)
                {
                        for (tempj = 3 ; tempj <= 5 ; tempj++)
                        {
                                if (sudoku[tempi][tempj] == val)
                                {
                                        return 1;
                                }
                        }
                }


                
        }
	if ( j == 6 || j == 7 || j == 8)
        {
		for ( tempi = 6 ; tempi <= 8 ; tempi++)
                {
                        for (tempj = 6 ; tempj <= 8 ; tempj++)
                        {
                                if (sudoku[tempi][tempj] == val)
                                {
                                        return 1;
                                }
                        }
                }

        }


}


  return 0;
  // END TODO
}

// Function: is_val_valid
// Return true if the val is can be filled in the given entry.
// This funcion is called by solve_sudoku to utilize the above three functions to see if a number can be placed at the
// spot in the array sudoku[i][j].
// If it can be placed there, it will return 1.
int is_val_valid(const int val, const int i, const int j, const int sudoku[9][9]) 
{

  assert(i>=0 && i<9 && j>=0 && j<9);

  // BEG TODO
if ( (is_val_in_row(val,i,sudoku) == 1) || (is_val_in_col(val,j,sudoku) == 1) || ( is_val_in_3x3_zone(val,i,j,sudoku) == 1) )
{
	return 0;
}
return 1;
  // END TODO
}

// Procedure: solve_sudoku
// Solve the given sudoku instance.
// This is a backtracking recursive function in order to use the above functions and solve an inputted sudoku board.
int solve_sudoku(int sudoku[9][9]) 
{  // BEG TODO.
int i,j;
int tempi, tempj;
if ( is_board_full(sudoku) == 1 )
{
	return 1;
}
else
{
	i = 0;
	j = 0;	
	for (tempi = 0 ; tempi <= 8 ; tempi++)
	{
		for (tempj=0 ; tempj<= 8 ; tempj++)
		{
			if ( sudoku[tempi][tempj] == 0 )
			{
				i = tempi;
				j =tempj;
				tempj = 9;
				tempi = 9;
			}
		}
	}
	tempj = 0;
	tempi = 0;	
}
  
for (int num = 1; num <= 9; num++)
{
	if ( ( is_val_valid(num,i,j,sudoku) == 1))
	{
		sudoku[i][j] = num;
		if (solve_sudoku(sudoku) == 1)
		{
        		return 1;
		}
        	sudoku[i][j] = 0;
	}
}
 
  return 0;
  // END TODO.
	
}
// Procedure: print_sudoku
void print_sudoku(int sudoku[9][9])
{
  int i, j;
  for(i=0; i<9; i++) {
    for(j=0; j<9; j++) {
      printf("%2d", sudoku[i][j]);
    }
    printf("\n");
  }
}

// Procedure: parse_sudoku
void parse_sudoku(const char fpath[], int sudoku[9][9]) {
  FILE *reader = fopen(fpath, "r");
  assert(reader != NULL);
  int i, j;
  for(i=0; i<9; i++) {
    for(j=0; j<9; j++) {
      fscanf(reader, "%d", &sudoku[i][j]);
    }
  }
  fclose(reader);
}





