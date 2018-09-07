#include <stdio.h>
#include <stdlib.h>
#include "maze.h"
//Micaela Bernichio
//mdb2
//04-06-17

/*
 * createMaze -- Creates and fills a maze structure from the given file
 * INPUTS:       fileName - character array containing the name of the maze file
 * OUTPUTS:      None 
 * RETURN:       A filled maze structure that represents the contents of the input file
 * SIDE EFFECTS: None
 */
//This function takes the file and assigns each part of the maze struct to its correct value. For this, I parse a file and take all of the maze info
//out of it in order to recreate the maze into a 2D array. '%' mark the walls, spaces mark the open paths, S marks the beginning of the maze and 
//E marks the end of the maze. The correct size for the maze and its cells are allocated in memory using malloc and a pointer is returned out fo the funtion
//pointing to the structure that contains the contents of the input file. 
maze_t * createMaze(char * fileName)
{
 
	int col,row;
	FILE *mazefile;				
	mazefile = fopen(fileName , "r");         //open the input file with the maze       	
	fscanf(mazefile, "%d", &row);
	fgetc(mazefile);
	fscanf(mazefile, "%d", &col);
	fgetc(mazefile);                          //gets the row and col dimenstions from the file
	int i,j;
	int startcol,startrow,endrow,endcol;					  		 
	maze_t * startmaze = malloc(sizeof(maze_t) );           // allocates size for the maze
	startmaze->cells =(char**)malloc(row*sizeof(char*)) ;      //allocates size for rows
	for (i=0 ; i < row ; i++)
	{ 
		startmaze->cells[i] =(char*)malloc(col*sizeof(char)) ;   //allocates size for the columns part of the rows
	}
	startmaze->width = row;
	startmaze->height =col;			          //sets the width and height of the maze
	for(i=0 ; i<row ; i++)
	{
		for(j=0; j<col ; j++)
		{
			fscanf(mazefile,"%c", &startmaze->cells[i][j]);	
			if ( startmaze->cells[i][j] == 'S')
			{
				startcol = j;
				startrow = i;
			}
			if ( startmaze->cells[i][j] == 'E')
			{
				endcol = j;
				endrow = i;
			}
				
		}
		fgetc(mazefile);
	}                                                 //sets up the game board based on the input from the file and finds the start and end
	startmaze->startColumn = startcol;
	startmaze->startRow = startrow;
	startmaze->endColumn = endcol;
	startmaze->endRow = endrow;                //sets the start/end row/column for the maze
	fclose(mazefile);                       //closes file
	return startmaze;                   //returns the pointer to the maze
}

/*
 * destroyMaze -- Frees all memory associated with the maze structure, including the structure itself
 * INPUTS:        maze -- pointer to maze structure that contains all necessary information 
 * OUTPUTS:       None
 * RETURN:        None
 * SIDE EFFECTS:  All memory that has been allocated for the maze is freed
 */
//This funtion is used at the very end of the program so that the memory that was allocated during the process is now freed up so that memory
//could potentionally be used again by the program. 
void destroyMaze(maze_t * maze)
{
    	int i;
	for (i=0; i<maze->height ;i++)
	{
		free(maze->cells[i]);
	}
	free(maze->cells);                //frees the cells
	free(maze);                     //frees the maze itself
	return;
}

/*
 * printMaze --  Prints out the maze in a human readable format (should look like examples)
 * INPUTS:       maze -- pointer to maze structure that contains all necessary information 
 *               width -- width of the maze
 *               height -- height of the maze
 * OUTPUTS:      None
 * RETURN:       None
 * SIDE EFFECTS: Prints the maze to the console
 */
//This funtion prints the maze pointed to by the input pointer by using nested for loops to go through each element and print it to the screen in 
//the correct maze display format.
void printMaze(maze_t * maze)
{
	int i,j;
	for(i=0 ; i < maze->height ; i++)
	{
		
		for(j=0 ; j < maze->width ; j++)
		{
				printf("%c", maze->cells[i][j]);
		}
		printf("\n");                          //prints each row of the maze onto the screen
	}
	
}


/*
 * solveMazeManhattanDFS -- recursively solves the maze using depth first search,
 * INPUTS:               maze -- pointer to maze structure with all necessary maze information
 *                       col -- the column of the cell currently beinging visited within the maze
 *                       row -- the row of the cell currently being visited within the maze
 * OUTPUTS:              None
 * RETURNS:              0 if the maze is unsolvable, 1 if it is solved
 * SIDE EFFECTS:         Marks maze cells as visited or part of the solution path
 */ 
//This function uses recursive backtracking in order to solve the given maze. It takes in the pointer to the maze structure, the current row,
//and the current column in order to see if a given path is valid in order to reach the end. Paths are marked by "." if it is a valid path
//and invalid but tried paths are marked by "~". 
int solveMazeManhattanDFS(maze_t * maze, int col, int row)
{
	if ( maze->cells[row][col] == 'E' )
	{
		maze->cells[maze->startRow][maze->startColumn] = 'S';        //base case that states if END is reached, the maze is solved
		return 1;
	}
	else 
	{
		if ( (col<maze->width) &&  (row<maze->height) && (col>=0) && (row>=0))
		{	
			if ( (maze->cells[row][col]== ' ') || (maze->cells[row][col] == 'S') )
			{
				maze->cells[row][col] = '.';
		
				if ((solveMazeManhattanDFS(maze,col-1,row) == 1))         //path to the left
				{
					return 1;
				}
				if ((solveMazeManhattanDFS(maze,col+1,row) == 1))        //path to the right
				{
					return 1;
				}
				if ((solveMazeManhattanDFS(maze,col,row-1) == 1))        //path above
				{
					return 1;
				}
				if ((solveMazeManhattanDFS(maze,col,row+1) == 1))         //path below
				{
					return 1;
				}
				maze->cells[row][col] = '~';                               //backtracking recursion that finds the path the end of the maze
			}
		}
	}

    return 0;
}


