// Micaela Bernichio
// mdb2
//03-02-17
// This file contains 3 functions each of which is utilized in main.c to serve a purpose.
// The purposes of these functons contributes to the overall game.
// The first function takes the seed inputted by the user, and checks
// to see if the seed is valid. If valid, then it enters the seed into the random function generator.
// Else, it displays an error message.
// The second function takes that seed and generates random numbers to make the solution answer.
// The solutions are modded by 8 and +1, and are then stored in pointers.
// The final function takes a guess inputted from the user and first checks to see if the guess is
// valid. If the guess is valid, then it compares misplaced and perfect pairs to the solution and then 
// displays a message back to the user. If the guess is equal to the solution, then the prorgram ends.




#include <stdio.h>
#include <stdlib.h>
#include "prog5.h"


static int guess_number;
static int solution1;
static int solution2;
static int solution3;
static int solution4;


/*
 * INPUTS: seed_str -- a string (array of characters) entered by the user, containing the random seed
 * OUTPUTS: none
 * RETURN VALUE: 0 if the given string is invalid (string contains anything
 *               other than a single integer), or 1 if string is valid (contains one integer)
*/
int
set_seed (const char seed_str[])
{

	
	int seed=0;
	char post[2];
	if (sscanf (seed_str, "%d%s", &seed, post)==1)      // checks to see if seed is valid
	{
		sscanf (seed_str, "%d%s",&seed, post);
		if (seed == 0)
		{
			printf("set_seed: invalid seed\n");  // if seed is one quantity, it checks to see if the seed contains only integers
 			return 0;                            //prints error message and returns 0 if quantity contains things that are not integers
		}
		srand (seed);                              
		return 1;	                           //if seed is valid, puts the seed through the random genereator function and returns 1
	
	}	
		
	else
	{
		printf("set_seed: invalid seed\n");       //if quantity did not = 1, print error message and return 0
		return 0;
	
	}

}



// INPUTS: none
// OUTPUTS: *one -- the first solution value (between 1 and 8)
//         *two -- the second solution value (between 1 and 8)
//          *three -- the third solution value (between 1 and 8)
//         *four -- the fourth solution value (between 1 and 8)
// RETURN VALUE: none
void
start_game (int* one, int* two, int* three, int* four)
{
	solution1 = rand() % 8; 
	solution1 = solution1 + 1;
	solution2 = rand() % 8;
	solution2 = solution2 + 1;
	solution3 = rand() % 8;
	solution3 = solution3 +1;
	solution4 = rand() % 8;
	solution4 = solution4 +1;    // generates 4 "random" numbers and stores them in solution1,...,solution4 respectively 
	guess_number = 1;            //initializes guess = 1
	*one = solution1;
	*two = solution2;
	*three = solution3;
	*four = solution4;          //value of generated solution stored at pointers   
    
}

// Function: make_guess
//  INPUTS: guess_str -- a string consisting of the guess typed by the user
//  OUTPUTS: the following are only valid if the function returns 1 (A valid guess)
//           *one -- the first guess value (between 1 and 8) //*          *two -- the second guess value (between 1 and 8)
//           *three -- the third guess value (between 1 and 8)
//           *four -- the fourth color value (between 1 and 8)
// RETURN VALUE: 1 if the guess string is valid (the guess contains exactly four
int
make_guess (const char guess_str[], int* one, int* two, 
	    int* three, int* four)
{

	int w,x,y,z = 0 ;
	char post[2];
	int i=0;
	int perfectmatch=0;
	int misplacedmatch=0;
	if (sscanf( guess_str, "%d%d%d%d%s", &w, &x, &y, &z, post)  != 4)
	{
		printf("make_guess: invalid guess\n");
		return 0;	
	}
	sscanf(guess_str, "%d%d%d%d%s", &w, &x, &y, &z, post);
	if (w==0 || x==0 || y==0 || z==0)
	{
		printf("make_guess: invalid guess\n");
		return 0;	
	}
	if (w>8 || x>8 || y>8 || z>8)
	{
		printf("make_guess: invalid guess\n");
		return 0;
	}                                                                       //checks to see if user guess syntax is valid
	*one = w;
	*two = x;
	*three = y;
	*four = z;
	int guess[4] = {w,x,y,z};
	int solution[4] = {solution1, solution2, solution3, solution4};
	for (i = 0; i<4 ; i++)
	{
		if (guess[i] == solution[i])
		{
			perfectmatch = perfectmatch +1;
			guess[i] = 0;
			solution[i] = 9;                                  //array and loop to check and see if there are any perfect matches between guess and solution
		}
		
			
	}
	int j =0;
	i = 0;
	for (i = 0; i<4 ; i++)
		{
			j=0;
			while  (j<4)
			{
				if (guess [i] == solution [j])
				{
					misplacedmatch = misplacedmatch + 1;
					guess [i] = 0;
					solution [j] = 9;                          //array and loop to check and see if there are any misplaced matches b/t guess and solution
				}			
				j++;
			}
			
		}

	printf("With guess %d, you got %d perfect matches and %d misplaced matches.\n", guess_number,perfectmatch,misplacedmatch);
	guess_number = guess_number +1;
                                                                                                                                   // after each guess, # of perfect and misplaced matches are printed
	                                                                                                                           // guess counter increments
    return 1;
}


