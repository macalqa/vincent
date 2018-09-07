//This file contains 3 functions which contribute to the main.c in order to play the game of life. Descriptions of each function come right before the 
//functions below. countLiveNeighbor doesn't appear in main however it is necessary in order to utilize the other two functions.
// This file is used by main to complete the game of life and display it onto the montior in steps. 
//The game stops when steps >20 or all of the cells die. With the use of pointers and 
//arrays, I stored the gameboard as a 1D array and accessed the values as if pulling from a matrix of row*column size.



/*
 * countLiveNeighbor
 * Inputs:
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * row: the row of the cell that needs to count alive neighbors.
 * col: the col of the cell that needs to count alive neighbors.
 * Output:
 * return the number of alive neighbors. There are at most eight neighbors.
 * Pay attention for the edge and corner cells, they have less neighbors.
 */

int countLiveNeighbor(int* board, int boardRowSize, int boardColSize, int row, int col)
{
int cell, cellabove, cellbelow ;
int alivecount = 0;
cell = (row * boardColSize + col);
cellabove = ( (row - 1) * boardColSize + col);
cellbelow = ( (row + 1) * boardColSize + col);
if ( col  == 0)                                      // index is in column 0
{
	if ( row  == 0 )                     // top left corner
	{
		if ( board[cell + 1] == 1 )
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellbelow] == 1 )
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellbelow + 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		return alivecount;

	}
	else if ( row == boardRowSize - 1 )    // bottom left corner
	{
		if ( board[cell + 1] == 1 )
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellabove] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellabove + 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		return alivecount;
	}
	else if ( ( row != 0 ) && (row != boardRowSize - 1) )    // leftside edge
	{
		if ( board[cell + 1] == 1)
		{
			alivecount = alivecount + 1;
		} 		
		if ( board[cellabove] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellabove + 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellbelow] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellbelow + 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		return alivecount;

	}
}
if ( col == boardColSize -1 )      // cell index in last column
{
	if ( row == 0 )        // top right corner
	{
		if ( board[cell - 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellbelow] == 1)
		{
			alivecount = alivecount + 1;	
		}
		if ( board[cellbelow - 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		return alivecount;
	}
	else if ( row == boardRowSize-1 )         // bottom right corner 
	{
		if ( board[cell - 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellabove] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellabove - 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		return alivecount;
	}
	else if ( ( row != 0 ) && (row != boardRowSize - 1) )     //rightside edge
	{
		if ( board[ cell - 1 ] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellabove] == 1)
		{
			alivecount = alivecount + 1;
		}
		if (board[cellabove -1] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellbelow] == 1)
		{
			alivecount = alivecount + 1;
		}
		if ( board[cellbelow - 1] == 1)
		{
			alivecount = alivecount + 1;
		}
		return alivecount;
	}
}
if ( row == 0 )    //top edge
{
	if ( board[cell + 1] == 1)
	{
		alivecount = alivecount + 1;
	}	
	if ( board[cell - 1] == 1)
	{
		alivecount = alivecount + 1;
	}
	if ( board[cellbelow] == 1)
	{
		alivecount = alivecount + 1;
	}
	if ( board[cellbelow + 1] == 1)
	{
		alivecount = alivecount + 1;
	}
	if ( board[cellbelow - 1] == 1) 
	{
		alivecount = alivecount + 1;
	}
	return alivecount;

}
if ( row == boardRowSize-1 )    //bottom edge
{
	if ( board[cell + 1] == 1)
	{
		alivecount = alivecount + 1;
	}
	if ( board[cell - 1] == 1)
	{
		alivecount = alivecount + 1;
	}
	if ( board[cellabove] == 1 )
	{
		alivecount = alivecount + 1;
	}
	if ( board[cellabove + 1] == 1)
	{
		alivecount = alivecount + 1;
	}
	if ( board[cellabove - 1] == 1)
	{
		alivecount = alivecount + 1;
	}
	return alivecount;
}	
if ( board[cell + 1] == 1)           //middle aka surrounded by eight neighbors
{
	alivecount = alivecount + 1;
}
if ( board[cell - 1] == 1)
{
	alivecount = alivecount + 1;
}
if ( board[cellabove] == 1)
{
	alivecount = alivecount + 1;
}
if ( board[cellabove + 1] == 1)
{
	alivecount = alivecount + 1;
}
if ( board[cellabove - 1] == 1)
{
	alivecount = alivecount + 1;
}
if ( board[cellbelow] == 1 )
{
	alivecount = alivecount + 1;
}
if ( board[cellbelow + 1] == 1)
{
	alivecount = alivecount + 1;
}
if ( board[cellbelow - 1] == 1)
{
	alivecount = alivecount + 1;
}
return alivecount ;
}
/*
 * Update the game board to the next step.
 * Input: 
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * Output: board is updated with new values for next step.
 */
void updateBoard(int* board, int boardRowSize, int boardColSize) 
{
	int i,j;      // row, column
	int neighbors;
	int index;                                       
	int tempboard[boardRowSize*boardColSize] ;
	for ( i = 0; i <= boardRowSize-1; i++ )
	{
		for ( j = 0 ; j <= boardColSize-1 ; j++ )
		{
			index = (i * boardColSize + j);                                            
			neighbors = countLiveNeighbor( board, boardRowSize, boardColSize, i,  j);   //calls function to get # of neighbors
			if (board[index] == 0 )
			{
				if (neighbors == 3)
				{
					tempboard[index] = 1;
				}
				else
				{
					tempboard[index] = board [index];
				}
			}
			if (board[index] == 1)
			{
				if ( (neighbors != 2) && (neighbors != 3) )
				{
					tempboard[index] = 0;
				}
				else
				{
					tempboard[index] = board[index];	
				}                                                   //applies game rules to cells
			}
			
		}
	}
int x,y;
int index2;
	for (x = 0 ; x <= boardRowSize-1 ; x++ )
	{
		for ( y = 0 ; y <= boardColSize-1 ; y++)
		{
			index2 = (x * boardColSize + y);

			board[index2] = tempboard [index2];               //stores the new board into board
		}
	}
}

/*
 * aliveStable
 * Checks if the alive cells stay the same for next step
 * board: 1-D array of the current game board. 1 represents a live cell.
 * 0 represents a dead cell
 * boardRowSize: the number of rows on the game board.
 * boardColSize: the number of cols on the game board.
 * Output: return 1 if the alive cells for next step is exactly the same with 
 * current step or there is no alive cells at all.
 * return 0 if the alive cells change for the next step.
 */ 
int aliveStable(int* board, int boardRowSize, int boardColSize)
{

				
	int i,j;      // row, column
        int neighbors;
        int index;
        int tempboard[boardRowSize*boardColSize];
        for ( i = 0; i <= boardRowSize-1; i++ )
        {
                for ( j = 0 ; j <= boardColSize-1 ; j++ )
                {
                        index = (i * boardColSize + j);
                        neighbors = countLiveNeighbor( board,  boardRowSize,  boardColSize,  i,  j);
                        if (board[index] == 0 )
                        {
                                if (neighbors == 3)
                                {
                                        tempboard[index] = 1;
                                }
				else
				{
					tempboard[index] = board[index];
				}
                        }
                        if (board[index] == 1)
                        {
                                if ( (neighbors != 2) && (neighbors != 3) )
                                {
                                        tempboard[index] = 0;
                                }
				else
				{
					tempboard[index] = board[index];
				}
                        }								//code to update tempboard with the iterations made by the next step
                       
                }
        }
	int x,y;
	int index2;
	 for (x = 0 ; x <= boardRowSize-1 ; x++ )
        {
                for ( y = 0 ; y <= boardColSize-1 ; y++)
                {
                        index2 = (x * boardColSize + y);

                      if ( board[index2] != tempboard [index2])          //checks to see if board and tempboard are the same return 1
			{
				return 0;
			}
                }
        }

     
 return 1;
}				
			

