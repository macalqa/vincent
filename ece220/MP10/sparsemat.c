#include "sparsemat.h"

#include <stdio.h>
#include <stdlib.h>

//micaela bernichio
//mdb2
//04-13-16
//This program uses various functions in order to do operations on sparse matrices
//there are also a few helper functions added in to help out with what
//needs to be done.


void delete_tuples(int row, int col, sp_tuples * head);
void insert_tuples(int row, int col, double val, sp_tuples * mat_t);

//this function takes the input from the file and translates it to a matrix 
//via linked lists.
sp_tuples * load_tuples(char* input_file)
{
	int row, col;
    FILE *file = fopen(input_file, "r");
    if (file == NULL)
      return NULL;
    fscanf(file, "%d %d", &row, &col);
    sp_tuples * tuple = malloc(sizeof(sp_tuples));
	tuple->tuples_head = (sp_tuples_node*)malloc(sizeof(sp_tuples_node));
    //tuple->tuples_head = NULL;
    tuple->m = row;
    tuple->n = col;
    int i, j;
    double k;
    while (!feof(file)){
      fscanf(file, "%d %d %lf\n", &i, &j, &k);
      if (k != 0)
        tuple->nz++;
    }
    rewind(file);
    fscanf(file, "%d %d", &row, &col);
    while(!feof(file)){
      fscanf(file, "%d %d %lf\n", &i, &j, &k);
      set_tuples(tuple, i, j, k);
    }
    fclose(file);
    return tuple;
}

//this function returns a value at a given row and col

double gv_tuples(sp_tuples * mat_t,int row,int col)

{
    sp_tuples_node * curr = mat_t->tuples_head;
    while ((curr != NULL)){
      if ((curr->row * mat_t->n + curr->col) == (row * mat_t->n + col))
        return curr->value;
      curr = curr->next;
    }
	return 0.0;
}


//this function calls many of the other functions in order to sort the list 
//and set it up the correct way
void set_tuples(sp_tuples * mat_t, int row, int col, double value)
{
    sp_tuples_node * curr = mat_t->tuples_head;
	sp_tuples_node * prev = mat_t->tuples_head;
    /*if (value == 0 && curr == NULL)     //if first entry is 0
      return;*/
    if (value == 0){               //delete node if it's a 0 entry
      //delete_tuples(row, col, mat_t);
      return;
    }
    else if (curr == NULL){             //if this is the first entry
      insert_tuples(row, col, value, mat_t);
      return;
    }
    else{
      if (curr != NULL){
        if (curr->row == row && curr->col == col){  //if find a repeat value at same column and row
          curr->value = value;
        }
        else
          insert_tuples(row, col, value, mat_t);    //insert and live time sort
      }
	  prev = curr;
	  curr = curr->next;
      return;		
    }
}

//this functions saves the matrix back into the file

void save_tuples(char * file_name, sp_tuples * mat_t)
{
	int rows, cols, row, col;
	double value;
    sp_tuples_node * node = mat_t->tuples_head;
    FILE *file = fopen(file_name, "w");
	rows = mat_t->m;
    cols = mat_t->n;
    fprintf(file, "%d %d", rows, cols);
    while (node != NULL){
      row = node->row;
	  col = node->col;
	  value = node->value;
      fprintf(file, "%d %d %lf", row, col, value);
      node = node->next;
    }
    fclose(file);
	return;
}

//this function adds two sparse matrices together vis linked lists

sp_tuples * add_tuples(sp_tuples * matA, sp_tuples * matB){
    if (matA->m != matB->m || (matA->n != matB->n))
    return NULL;
    int i, j;
    sp_tuples * matC = (sp_tuples*)malloc(sizeof(sp_tuples));
    matC->m = matA->m;
    matC->n = matA->n;
    matC->tuples_head = (sp_tuples_node*)malloc(sizeof(sp_tuples_node));
    //matC->tuples_head = NULL;
    sp_tuples_node * nodeA = matA->tuples_head;
    sp_tuples_node * nodeB = matB->tuples_head;
    sp_tuples_node * nodeC = matC->tuples_head;
	
    while (nodeA != NULL){
	  insert_tuples(nodeA->row, nodeA->col, nodeA->value, matC);
	  nodeA = nodeA->next;
    }
	nodeC= matC->tuples_head;
	while (nodeB!=NULL && nodeC!=NULL){
      if (nodeB->row == nodeC->row && nodeB->col == nodeC->col){
        nodeC->value = nodeC->value + nodeB->value;
        nodeB = nodeB->next;
        nodeC = nodeC->next;
        continue;
      }
      insert_tuples(nodeB->row, nodeB->col, nodeB->value, matC);
      nodeB = nodeB->next;
      nodeC = nodeC->next;
    }
    free(nodeC);
	return matC;
}
//this function multiplies two sparse matrices
sp_tuples * mult_tuples(sp_tuples * matA, sp_tuples * matB)
{
	sp_tuples* retmat = (sp_tuples*)malloc(sizeof(sp_tuples));
//	retmat->tuples_head = (sp_tuples_node*)malloc(sizeof(sp_tuples_node));
/*	double sum = 0.0;
	retmat->n = matA->n;
	retmat->m = matB->m;
	sp_tuples_node* nodeA = matA->tuples_head;
	sp_tuples_node* nodeC = retmat->tuples_head;
	sp_tuples_node* nodeB = matB->tuples_head;
	while (nodeB != NULL && nodeA !=NULL)
	{
		while (nodeB->row == nodeA->col) 
		{
			if (nodeA->col == nodeB->row) 
			{
         multiply them and store in new matrix//
        			sum += (nodeA->value * nodeB->value);
        			set_tuples(retmat, nodeA->row, nodeB->col, sum);
      			}
       			nodeB = nodeB->next;
    		}
    		nodeA = nodeA->next;
  	}	*/
    return retmat;
}
//this functions frees up all of the memory that was allocated
void destroy_tuples(sp_tuples * mat_t){
	sp_tuples_node * curr = mat_t->tuples_head;
	sp_tuples_node * temp;
	while (curr != NULL){
		temp = curr->next;
		free(curr);
		curr = temp;
    }
    free(mat_t);
    return;
}  

//helper function that deletes a node of linked list
void delete_tuples(int row, int col, sp_tuples * mat_t){
	sp_tuples_node ** list = &(mat_t->tuples_head);
    sp_tuples_node * curr = *list;
    sp_tuples_node * prev = *list;
    while (curr != NULL && curr->next != NULL){
      if (curr->row == row && curr->col == col)
        break;
      prev = curr;
      curr = curr->next;
    }
    if (curr == *list){          			    //if first node
      *list = curr->next;
    }
    /*else if (curr->next == NULL){               //if last node
      prev->next = NULL;
    }*/
    else{                                       //in middle
      prev->next = curr->next;
    }
    free(curr);                                 //destroys node from memory
	return;
}

//helper function that inserts a node in a linked list
void insert_tuples(int row, int col, double val, sp_tuples * mat_t){
    sp_tuples_node ** list = &(mat_t->tuples_head);
    sp_tuples_node * prev = * list;
    sp_tuples_node * curr = * list;
    //make a new node and set all the correct values inside
    sp_tuples_node* new = (sp_tuples_node *)malloc(sizeof(sp_tuples_node));
    new->value = val;
    new->row = row;
    new->col = col;
    new->next = NULL;
    while(curr != NULL){
	  /*if (curr->value == 0)
         return;*/
      if (curr->value == 0)
		*list = new;
      //if index is smaller than node we are at
      if ((new->row * mat_t->n + new->col) < (curr->row * mat_t->n + curr->col)){
        new->next = curr;
        if (curr == *list)
          *list = new;
        else
          prev->next = new;
        return;
      }
      //if new node has to be inserted at tail
      if (curr->next == NULL){
        curr->next = new;
        new->next = NULL;
      }
      prev = curr;
      curr = curr->next;
    }
	return;
}




