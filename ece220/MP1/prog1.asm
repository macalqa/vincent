;
; The code given to you here implements the histogram calculation that 
; we developed in class.  In programming studio, we will add code that
; prints a number in hexadecimal to the monitor.
;
; Your assignment for this program is to combine these two pieces of 
; code to print the histogram to the monitor.
;
; If you finish your program, 
;    ** commit a working version to your repository  **
;    ** (and make a note of the repository version)! **


	.ORIG	x3000		; starting address is x3000


;
; Count the occurrences of each letter (A to Z) in an ASCII string 
; terminated by a NUL character.  Lower case and upper case should 
; be counted together, and a count also kept of all non-alphabetic 
; characters (not counting the terminal NUL).
;
; The string starts at x4000.
;
; The resulting histogram (which will NOT be initialized in advance) 
; should be stored starting at x3F00, with the non-alphabetic count 
; at x3F00, and the count for each letter in x3F01 (A) through x3F1A (Z).
;
; table of register use in this part of the code
;    R0 holds a pointer to the histogram (x3F00)
;    R1 holds a pointer to the current position in the string
;       and as the loop count during histogram initialization
;    R2 holds the current character being counted
;       and is also used to point to the histogram entry
;    R3 holds the additive inverse of ASCII '@' (xFFC0)
;    R4 holds the difference between ASCII '@' and 'Z' (xFFE6)
;    R5 holds the difference between ASCII '@' and '`' (xFFE0)
;    R6 is used as a temporary register
;

			LD R0,HIST_ADDR      ; point R0 to the start of the histogram
	
	; fill the histogram with zeroes 
			AND R6,R6,#0		; put a zero into R6
			LD R1,NUM_BINS		; initialize loop count to 27
			ADD R2,R0,#0		; copy start of histogram into R2

	; loop to fill histogram starts here
HFLOOP		STR R6,R2,#0		; write a zero into histogram
			ADD R2,R2,#1		; point to next histogram entry
	   	 	ADD R1,R1,#-1		; decrement loop count
			BRp HFLOOP		    ; continue until loop count reaches zero

	; initialize R1, R3, R4, and R5 from memory
			LD R3,NEG_AT		; set R3 to additive inverse of ASCII '@'
			LD R4,AT_MIN_Z		; set R4 to difference between ASCII '@' and 'Z'
			LD R5,AT_MIN_BQ		; set R5 to difference between ASCII '@' and '`'
			LD R1,STR_START		; point R1 to start of string
	
	; the counting loop starts here

COUNTLOOP	LDR R2,R1,#0		; read the next character from the string
			BRz PRINT_HIST		; found the end of the string

			ADD R2,R2,R3		; subtract '@' from the character
			BRp AT_LEAST_A		; branch if > '@', i.e., >= 'A'

NON_ALPHA	LDR R6,R0,#0		; load the non-alpha count
			ADD R6,R6,#1		; add one to it
			STR R6,R0,#0		; store the new non-alpha count
			BRnzp GET_NEXT		; branch to end of conditional structure

AT_LEAST_A	ADD R6,R2,R4		; compare with 'Z'
			BRp MORE_THAN_Z      ; branch if > 'Z'

; note that we no longer need the current character
; so we can reuse R2 for the pointer to the correct
; histogram entry for incrementing
ALPHA		ADD R2,R2,R0		; point to correct histogram entry
			LDR R6,R2,#0		; load the count
			ADD R6,R6,#1		; add one to it
			STR R6,R2,#0		; store the new count
			BRnzp GET_NEXT		; branch to end of conditional structure

; subtracting as below yields the original character minus '`'
MORE_THAN_Z	ADD R2,R2,R5		; subtract '`' - '@' from the character
			BRnz NON_ALPHA		; if <= '`', i.e., < 'a', go increment non-alpha
			ADD R6,R2,R4		; compare with 'z'
			BRnz ALPHA		    ; if <= 'z', go increment alpha count
			BRnzp NON_ALPHA		; otherwise, go increment non-alpha

GET_NEXT	ADD R1,R1,#1		; point to next character in string
			BRnzp COUNTLOOP		; go to start of counting loop


; you will need to insert your code to print the histogram here

; Micaela Bernichio
;mdb2
;Jan.26,2017
;R0-trap interface
;R1-line counter
;R2-Digit counter
;R3-ascii character count
;R4-digit
;R5-bit counter and 'placeholder'
;R6-another placeholder
;This program counts accurances of ASCII characters and prints them to a screen for all 27 letters of the alphabet and places them into a histogram form. 


PRINT_HIST 	AND R6,R6,#0	
			ADD R6,R6,R0
			AND R1,R1,#0
			LD R1,Count         ;initialize R7 as counter and store #27
RESTART		ADD R1,R1,#-1
			BRn FINISH
			LD R0,Char_Hex      ;
			OUT
			ADD R0,R0,#1
			ST R0, Char_Hex
			LD R0,Space
			OUT
			AND R3,R3,#0       ;initialize R3
			LDR R3,R6,#0       ;store value of R6 into R3

			AND R2,R2,#0
			ADD R2,R2,#4 	    ;initialize digit counter
DIGIT		ADD R2,R2,#-1 		;decrement digit counter
			BRn DONE      		;branch to DONE if 4 digits have been printed
			AND R4,R4,#0  
			AND R5,R5,#0
			ADD R5,R5,#4  		;initialize digit and bit counter
BIT			ADD R5,R5,#-1 		;decrement bit counter
			BRn FOUR      		;branch to FOUR if four bits of R3 have been "read"
			ADD R4,R4,R4  		;shifting digit left
			ADD R3,R3,#0
			BRn ONE       		;branch to ONE if R3 is less then 0
			ADD R4,R4,#0  
			ADD R3,R3,R3  		;adds 0 to digit and shifts R3 left
			BRnzp BIT     		;branches back to BIT
ONE			ADD R4,R4,#1  
			ADD R3,R3,R3  		;adds 1 to digit and shifts R3 left
			BRnzp BIT     		;branches back to BIT
FOUR   		AND R5,R5,#0  
			ADD R5,R5,R4  		;initialized R5 and loaded it with the contents of R4
			ADD R5,R5,#-10 
			BRn ZERO      		;check to see if contents of R5 -10, or 'xA', is < 0
			AND R0,R0,#0
			LD  R0,Sixfive 	    ;
			ADD R0,R0,R4        ;add 65       
			ADD R0,R0,#-10		;if >= 0, R4 is subtracted by 10
			OUT			  		;then outputted to monitor
			BRnzp DIGIT
ZERO		AND R0,R0,#0
			LD R0,Zero1
			ADD R4,R4,#0  		;if R5-10 < 0 then 0 is added to R4
			ADD R0,R0,R4  		;store value of R4 into R0
			OUT           
			Brnzp DIGIT

DONE  		LD R0,New_Line
			OUT
			ADD R6,R6,#1
			Brnzp RESTART




Sixfive 	.FILL x41
Zero1		.FILL x30
Count	 	.Fill #27
Char_Hex	.Fill x40
Space       .Fill x20
New_Line    .Fill #10


; the data needed by the program
NUM_BINS	.FILL #27		 ; 27 loop iterations
NEG_AT		.FILL xFFC0		 ; the additive inverse of ASCII '@'
AT_MIN_Z	.FILL xFFE6		 ; the difference between ASCII '@' and 'Z'
AT_MIN_BQ	.FILL xFFE0		 ; the difference between ASCII '@' and '`'
HIST_ADDR	.FILL x3F00		 ; histogram starting address
STR_START	.FILL x4000 	 ; string starting address




FINISH	HALT			; done


; the data needed by the program

; for testing, you can use the lines below to include the string in this
; program...
; STR_START	.FILL STRING	; string starting address
; STRING		.STRINGZ "This is a test of the counting frequency code.  AbCd...WxYz."



	; the directive below tells the assembler that the program is done
	; (so do not write any code below it!)

	.END
