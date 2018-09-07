; Implement a program to find the nearest smaller (or equal) perfect square of a given positive number
; The input will be stored in R2 and output (the nearest perfect square) should be stored in R3
; TODO: Write a subroutine called "PSquare" which returns the nearest perfect square of a given input and 
;       you must invoke this subroutine in the main part.
; Note : R2, R4, R5 and R6 must be left unchanged in PSquare.
;
; 
; PSquare :  input is stored in R2
;            output is stored in R3

.ORIG	x3000		; starting address is x3000

;;YOUR CODE STARTS HERE
AND R1,R1,#0
AND R3,R3,#0
AND R4,R4,#0
AND R5,R5,#0
AND R6,R6,#0
ADD R3,R3,#1
AND R0,R0,#0
JSR PSquare
HALT




PSquare
	ST R7,SAVE_R7
	ST R2,SAVE_R2
	ST R0,SAVE_R0
	ST R1,SAVE_R1
	BRnzp START
OUTER
	
	ADD R1,R1,#1
	AND R0,R0,#0
	ADD R0,R0,R1
	NOT R0,R0
	ADD R0,R0,#1
	AND R3,R3,#0
	ADD R3,R3,R2
	ADD R0,R0,R2
	BRn DONE
	ST R1,SAVE_N
	ADD R1,R1,#-1
START	ADD R1,R1,#1
	AND R0,R0,#0
	ADD R0,R0,R1
	AND R3,R3,#0
	ADD R3,R3,R1
LOOP
	ADD R3,R3,#-1
	BRz NEXT
	ADD R1,R1,R0
	BRnzp LOOP
	
NEXT
	ADD R2,R2,#0
	BRnzp OUTER
DONE
	LD R1,SAVE_N
	ADD R1,R1,#-1
	AND R0,R0,#0
	ADD R0,R0,R1
	AND R3,R3,#0
	ADD R3,R3,R1
	ADD R3,R3,#1
LOOP2
	ADD R1,R1,#-1
	BRz FINISH
	ADD R1,R1,R0
	BRnzp LOOP2	

	
FINISH
	AND R3,R3,#0
	ADD R3,R2,R1
	LD R7,SAVE_R7
	LD R2,SAVE_R2
	LD R0,SAVE_R0
	LD R1,SAVE_R1
	RET
SAVE_N  .BLKW #1
SAVE_R7 .BLKW #1
SAVE_R2 .BLKW #1
SAVE_R0 .BLKW #1
SAVE_R1 .BLKW #1
.END



