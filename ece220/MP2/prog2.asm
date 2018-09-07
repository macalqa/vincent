;This program takes a postfix expression and evaluates it by using a stack.It then prints the result in hexidecimal notation.
;The expressions are terminated with a semi colon and prints "Invalid Expression." when the postfix expression cannot be evaluated.
;R0 input from trap
;R1 used to check char values
;R6 is used to check to see if 

.ORIG x3000
	
;your code goes here
START   	
		GETC
		;LD R2, TEST_STR_START
		;ADD R2,R2,#1
		;LEA R0, R2
		;ST R2, TEST_STR_START
		OUT
		AND R2,R2,#0
		LD  R1,SEMI_COLON
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R0       ;checking to see if char is a semicolon
		BRz PRINTING
		LD  R1,SPACE
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R0
		BRz START          ;checking to see if char is 'space'
		JSR EVALUATE
		ADD R6,R6,#-1       ;checks to see if any underflow occured in subroutines
		BRz FAIL
		ADD R6,R6,#0
		BRnzp START        ;returns to get a new character
	
FAIL
	LD R0, STRING 
	PUTS                       ;outputs "Invalid Expression"
	BRnzp DONE 
PRINTING
	JSR POP

	AND R3,R3,#0
	ADD R3,R3,R0
	
	AND R5,R5,#0
	ADD R5,R5,R3
	JSR PRINT_HEX                       ;setting R5 to the computed value
	BRnzp DONE
DONE
	HALT

;TEST_STR_START .FILL TEST_STR
;TEST_STR       .STRINGZ "23+;"

SIXTY      .FILL X0060
SEMI_COLON .FILL x003B
SPACE      .FILL x0020
STRING_START .FILL STRING
STRING .STRINGZ "Invalid Expression."
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;R3- value to print in hexadecimal
PRINT_HEX
		ST R7,PRINTSAVE_R7
		ST R4,PRINTSAVE_R4
		ST R2,PRINTSAVE_R2
		ST R3,PRINTSAVE_R3

		ADD R2,R2,#0
		ADD R2,R2,#4 	        ;initialize digit counter
DIGIT	        
		ADD R2,R2,#-1 		;decrement digit counter
		BRn RETURN              ;branch to RETURN if 4 digits have been printed
		AND R4,R4,#0  
		AND R1,R1,#0
		ADD R1,R1,#4  		;initialize digit and bit counter
BIT		
		ADD R1,R1,#-1 		;decrement bit counter
		BRn FOUR      		;branch to FOUR if four bits of R3 have been "read"
		ADD R4,R4,R4  		;shifting digit left
		ADD R3,R3,#0
		BRn ONE       		;branch to ONE if R3 is less then 0
		ADD R4,R4,#0  
		ADD R3,R3,R3  		;adds 0 to digit and shifts R3 left
		BRnzp BIT     		;branches back to BIT
ONE		
		ADD R4,R4,#1  
		ADD R3,R3,R3  		;adds 1 to digit and shifts R3 left
		BRnzp BIT     		;branches back to BIT
FOUR            
		AND R5,R5,#0  
		ADD R5,R5,R4  		;initialized R5 and loaded it with the contents of R4
		ADD R5,R5,#-10 
		BRn ZERO      		;check to see if contents of R5 -10, or 'xA', is < 0
		AND R0,R0,#0
		LD  R0,Sixfive 	        ;
		ADD R0,R0,R4            ;add 65       
		ADD R0,R0,#-10		;if >= 0, R4 is subtracted by 10
		OUT			;then outputted to monitor
		BRnzp DIGIT
ZERO	        
		AND R0,R0,#0
		LD R0,Zero1
		ADD R4,R4,#0  		;if R5-10 < 0 then 0 is added to R4
		ADD R0,R0,R4  		;store value of R4 into R0
		OUT           
		Brnzp DIGIT
RETURN
		LD R3,PRINTSAVE_R3
		LD R7,PRINTSAVE_R7
		LD R4,PRINTSAVE_R4
		LD R2,PRINTSAVE_R2
		RET


PRINTSAVE_R3 .BLKW #1
PRINTSAVE_R4 .BLKW #1
PRINTSAVE_R2 .BLKW #1
PRINTSAVE_R7 .BLKW #1


Sixfive .FILL x41
Zero1	.FILL x30

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;R0 - character input from keyboard
;R6 - current numerical output
;
;
EVALUATE

;your code goes here
		ST R0,SAVE_R0
		ST R3,SAVE_R3
		ST R2,SAVE_R2
		ST R7,SAVE_R7
		ST R1,SAVE_R1

		LD R2, HEX_CONVERT
		ADD R0,R0,R2
		LD R1,NUM_MIN
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R0
		BRn OPERATION   ;if char is not > x00, jumps to operation branch
		LD R1,NUM_MAX   
		AND R3,R3,#0
		ADD R3,R3,R0
		NOT R0,R0
		ADD R0,R0,#1
		ADD R1,R1,R0
		BRnp NUM        ;if char is a number 0-9, branch to NUM
		
		AND R0,R0,#0
		ADD R0,R0,R3
		AND R2,R2,#0
		ADD R2,R2,R0
		LD  R1,CARET
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R2
		BRnp CHAR_FAIL ;if char is not ^, then not a valid char, fail
		BRz OPERATION
		
		
NUM
		AND R0,R0,#0
		ADD R0,R0,R3
		
		JSR PUSH       ;number is pushed onto stack
		BRnzp EVAL_DONE
OPERATION      
		LD  R0,SAVE_R0
		LD  R1,CARET
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R0
		BRnp EVAL_MULT 
		JSR EXP
		AND R1,R1,#0
		ADD R1,R1,R5
		ADD R1,R1,#-1
		BRz UNDERFLOW  ;checks for underflow from EXP
		ADD R1,R1,#0	
		
EVAL_MULT	LD  R1,MULT_CHAR
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R0
		BRnp CHECK1    ;checks to see if operation is multiplication
		JSR MUL
		AND R1,R1,#0
		ADD R1,R1,R5
		ADD R1,R1,#-1
		BRz UNDERFLOW  ;checks for underflow in MUL
		ADD R1,R1,#0
		BRnzp EVAL_DONE
CHECK1		
		LD R1,ADD_CHAR
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R0
		BRnp CHECK2    ;checks to see if operation is add
		JSR PLUS
		AND R1,R1,#0
		ADD R1,R1,R5
		ADD R1,R1,#-1
		BRz UNDERFLOW  ;checks for underflow in PLUS
		ADD R1,R1,#0
		BRnzp EVAL_DONE

CHECK2		
		LD R1,SUB_CHAR
		NOT R1,R1
		ADD R1,R1,#1
		ADD R1,R1,R0
		BRnp SKIP1     ;checks to see if operation is subtract
		JSR MIN
		AND R1,R1,#0
		ADD R1,R1,R5
		ADD R1,R1,#-1
		BRz UNDERFLOW  ;checks for underflow in MIN
		ADD R1,R1,#0
		BRnzp EVAL_DONE
SKIP1          
	 	JSR DIV
		AND R1,R1,#0
		ADD R1,R1,R5
		ADD R1,R1,#-1
		BRz UNDERFLOW  ;checks for underflow in DIV
		ADD R1,R1,#0
		BRnzp EVAL_DONE
	
UNDERFLOW	
		AND R6,R6,#0
		ADD R6,R6,#1
		BRnzp EVAL_DONE
		
	
CHAR_FAIL       
		AND R6,R6,#0
		ADD R6,R6,#1
		LD R2,SAVE_R2
		LD R7,SAVE_R7
		LD R3,SAVE_R3
		LD R1,SAVE_R1
		RET
	
EVAL_DONE 
	LD R3,SAVE_R3
	LD R7,SAVE_R7
	LD R1,SAVE_R1
 	RET

MULT_CHAR .FILL x002A
ADD_CHAR  .FILL x002B
SUB_CHAR  .FILL x002D
DIV_CHAR  .FILL x002F
CARET     .FILL x005E
NUM_MAX   .FILL x0009
NUM_MIN   .FILL x0000
SAVE_R0   .BLKW #1
SAVE_R7   .BLKW #1
SAVE_R3   .BLKW #1
SAVE_R2   .BLKW #1
SAVE_R1   .BLKW #1
HEX_CONVERT   .FILL #-48
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
PLUS	
;your code goes here
	ST R3,ADDSAVE_R3
	ST R7,ADDSAVE_R7
	ST R4,ADDSAVE_R4
	AND R0,R0,#0
	JSR POP
	AND R1,R1,#0
	ADD R1,R5,#-1   ;checks underflow
	BRz RETURN1
	AND R3,R3,#0
	ADD R3,R3,R0    ;R0->R3
  	JSR POP
	AND R1,R1,#0
	ADD R1,R5,#-1   ;checks underflow
	BRz RETURN1
	AND R4,R4,#0
	ADD R4,R4,R0	;R0->R4
	ADD R0,R3,R4    ;R3+R4->R0
	ADD R0,R0,#0
	JSR PUSH
RETURN1
	LD R3,ADDSAVE_R3
	LD R7,ADDSAVE_R7
	LD R4,ADDSAVE_R4
	RET

ADDSAVE_R7   .BLKW #1
ADDSAVE_R4   .BLKW #1
ADDSAVE_R3   .BLKW #1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
MIN	
;your code goes here
	ST R7,MINSAVE_R7
	ST R3,MINSAVE_R3
	ST R4,MINSAVE_R4	
	JSR POP
	AND R1,R1,#0
	ADD R1,R5,#-1   ;checks for underflow
	BRz RETURN2
	AND R3,R3,#0
	ADD R3,R3,R0    ;R0->R3
	JSR POP
	AND R1,R1,#0
	ADD R1,R5,#-1   ;checks for underflow
	BRz RETURN2
	ADD R4,R4,#0
	ADD R4,R4,R0    ;R0->R4
	NOT R3,R3
	ADD R3,R3,#1
	ADD R0,R3,R4    ;-R3+R4->R0
	JSR PUSH
RETURN2
	LD R7,MINSAVE_R7
	LD R3,MINSAVE_R3
	LD R4,MINSAVE_R4
	RET
	
MINSAVE_R7   .BLKW #1
MINSAVE_R3   .BLKW #1
MINSAVE_R4   .BLKW #1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
MUL	
;your code goes here
	ST R7,MULTSAVE_R7
	ST R3,MULTSAVE_R3
	ST R4,MULTSAVE_R4
	ST R2,MULTSAVE_R2
	JSR POP
	ADD R1,R1,#0
	ADD R1,R5,#-1   ;checks for underflow
	BRz RETURN3
	AND R3,R3,#0
	ADD R3,R3,R0    ;R0->R3, if R3 is zero, branch
	BRz MULT_ZERO1
	JSR POP
	AND R1,R1,#0
	ADD R1,R5,#-1   ;checks for underflow
	BRz RETURN3
	AND R4,R4,#0 
	ADD R4,R4,R0    ;R0->R4
	AND R2,R2,#0
	ADD R2,R2,R3    ;R3->R2
	ADD R4,R4,#0    
	BRz MULT_ZERO2  ;check to see if R4=0, if so branch
	ADD R4,R4,#0
	BRn MULT_NEG    ;checks to see if R4 is negative, if so branch
	ADD R2,R2,#0
	BRnzp MULT_REG  ;branch to regular multiplication
MULT_ZERO1
	JSR POP         
	AND R1,R1,#0
	ADD R1,R5,#-1   
	BRz RETURN3
	AND R0,R0,#0    
	JSR PUSH
	BRnzp RETURN3   ;if first value is 0, pops other value and pushes in 0
MULT_ZERO2	
	AND R0,R0,#0
	JSR PUSH
	BRz RETURN3     ;if the second value popped is 0, set R0=0, push
MULT_REG
	AND R6,R6,#0
	ADD R6,R6,R4    ;R4->R6
LOOP	ADD R2,R2,#-1
	ADD R4,R4,R6
	ADD R2,R2,#0
	BRnp LOOP       ;ADD R4 to R6 (itself) until R2 (the R3 value)decrements to 0
	AND R0,R0,#0
	ADD R0,R0,R4	;R4(computed value)->R0
	JSR PUSH

	BRnzp RETURN3
MULT_NEG
	NOT R4,R4
	ADD R4,R4,#1
	AND R6,R6,#0
	ADD R6,R6,R4    ;changes R4 into a positive value
NEGLOOP
	ADD R2,R2,#-1
	ADD R4,R4,R6
	ADD R2,R2,#0
	BRnp NEGLOOP    ;ADD R4 to R6 (itself) until R2 (the R3 value)decrements to 0
	AND R0,R0,#0
	NOT R4,R4
	ADD R4,R4,#1
	ADD R0,R0,R4
	ADD R0,R0,#1	;change value back to neg, R4->R0, pushed to stack
	JSR PUSH
	BRnzp RETURN3
RETURN3 
	LD R7,MULTSAVE_R7
	LD R3,MULTSAVE_R3
	LD R4,MULTSAVE_R4
	LD R2,MULTSAVE_R2 ;restore registers
	RET

MULTSAVE_R7   .BLKW #1
MULTSAVE_R3   .BLKW #1
MULTSAVE_R4   .BLKW #1
MULTSAVE_R2   .BLKW #1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
DIV	
;your code goes here
	ST R7,DIVSAVE_R7
	ST R3,DIVSAVE_R3
	ST R4,DIVSAVE_R4
	ST R2,DIVSAVE_R2
	JSR POP
	AND R1,R1,#0
	ADD R1,R5,#-1
	BRz RETURN5     ;check for overflow 
	AND R3,R3,#0
	ADD R3,R3,R0    ;R3<-R0
	JSR POP        
	AND R1,R1,#0
	ADD R1,R5,#-1
	BRz RETURN5    ;check for overflow
	AND R4,R4,#0
	ADD R4,R4,R0   ;R4<-R0
	BRn NEG_DEN    ;if dividend is neg, branch
	AND R1,R1,#0	
	ADD R1,R1,R3  
	NOT R1,R1
	ADD R1,R1,#1
	ADD R1,R1,R4
	BRz SAME       ; if dividend=divisor, branch
SMALL
	AND R1,R1,#0
	ADD R1,R1,R3
	NOT R1,R1
	ADD R1,R1,#1
	ADD R1,R1,R4
	BRn REMAIN    ;check to see if initial dividend is small than the divisor (R4<R3)
	AND R2,R2,#0
	NOT R3,R3
	ADD R3,R3,#1
LOOP32
	ADD R4,R4,R3
	ADD R2,R2,#1
	ADD R4,R4,#0
	BRz PUSHER    ; repeated subtraction until 0 
SMALL2
	AND R1,R1,#0
	ADD R1,R1,R3
	NOT R1,R1
	ADD R1,R1,#1
	ADD R1,R1,R4
	BRn REMAIN    ; checks to see if the current value in R4<R3, if true branch (meaning a remainder)
	ADD R0,R0,#0
	BRnzp LOOP32
REMAIN
	AND R0,R0,#0
	ADD R0,R0,R4
	JSR PUSH
	ADD R0,R0,#0
	BRnzp RETURN5  ;if remainder, push the quotient onto stack
PUSHER
	AND R0,R0,#0
	ADD R0,R0,R2 
	JSR PUSH       ;push value in R2 (quotient) onto stack
	ADD R0,R0,#0
	BRnzp RETURN5
SAME
	AND R0,R0,#0
	ADD R0,R0,#1
	JSR PUSH       ;pushes quotient of 1 to stack
	ADD R0,R0,#0
	BRnzp RETURN5


NEG_DEN
	NOT R4,R4
	ADD R4,R4,#1
	AND R1,R1,#0	
	ADD R1,R1,R3  
	NOT R1,R1
	ADD R1,R1,#1
	ADD R1,R1,R4
	BRz SAMENEG      ; if dividend=divisor, branch
SMALLNEG
	AND R1,R1,#0
	ADD R1,R1,R3
	NOT R1,R1
	ADD R1,R1,#1
	ADD R1,R1,R4
	BRn REMAINNEG   ;check to see if initial dividend is small than the divisor (R4<R3)
	AND R2,R2,#0
	NOT R3,R3
	ADD R3,R3,#1
LOOPNEG
	ADD R4,R4,R3
	ADD R2,R2,#1
	ADD R4,R4,#0
	BRz PUSHERNEG  ; repeated subtraction until 0 
SMALL2NEG
	AND R1,R1,#0
	ADD R1,R1,R3
	NOT R1,R1
	ADD R1,R1,#1
	ADD R1,R1,R4
	BRn REMAINNEG   ; checks to see if the current value in R4<R3, if true branch (meaning a remainder)
	ADD R0,R0,#0
	BRnzp LOOPNEG
REMAINNEG
	AND R0,R0,#0
	NOT R4,R4
	ADD R4,R4,#1
	ADD R0,R0,R4
	JSR PUSH
	ADD R0,R0,#0
	BRnzp RETURN5  ;if remainder, push the quotient onto stack
PUSHERNEG
	AND R0,R0,#0
	NOT R2,R2
	ADD R2,R2,#1
	ADD R0,R0,R2 
	JSR PUSH	  ;push value in R2 (quotient) onto stack
	ADD R0,R0,#0
	BRnzp RETURN5
SAMENEG
	AND R0,R0,#0
	ADD R0,R0,#-1
	JSR PUSH
	ADD R0,R0,#0
	BRnzp RETURN5
RETURN5
	LD R7,DIVSAVE_R7
	LD R3,DIVSAVE_R3
	LD R4,DIVSAVE_R4
	LD R2,DIVSAVE_R2
	RET
	
DIVSAVE_R7 .BLKW #1
DIVSAVE_R3 .BLKW #1
DIVSAVE_R4 .BLKW #1
DIVSAVE_R2 .BLKW #1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;input R3, R4
;out R0
EXP
;your code goes here
    ST R7,EXPSAVE_R7
	ST R3,EXPSAVE_R3
	ST R4,EXPSAVE_R4
	ST R2,EXPSAVE_R2
	JSR POP	
	AND R1,R1,#0
	ADD R1,R5,#-1    ;checks for underflow
	BRz RETURN6 
	AND R3,R3,#0
	ADD R3,R3,R0     ;R0->R3
	JSR POP
	AND R1,R1,#0
	ADD R1,R5,#-1    ;check for underflow
	BRz RETURN6
	AND R4,R4,#0
	ADD R4,R4,R0     ;R0->R4
CHECKE
	AND R2,R2,#0
	AND R1,R1,#0
	ADD R2,R2,R3     ;R3->R2
	ADD R1,R1,#2     ;R1=2
	NOT R2,R2 
	ADD R2,R2,#1       ;-R2
LOOPEXP
	AND R6,R6,#0
	ADD R6,R6,R3     ;R3->R6
	ADD R6,R6,R2     ;R6-2
	BRz EVENEXP      ;if 0, is divisble by 2 so even
	ADD R6,R6,#0
	BRn ODDEXP       ;if negative, not divisible by 2 so odd
	ADD R6,R6,#0
	BRnzp LOOPEXP    ;loop to check if the exponent is even or odd
EVENEXP
	ADD R4,R4,#0
	BRn CHANGE       ;if R4 is negative, branch
START1
	AND R0,R0,R0     
	ADD R0,R4,R4     
START2
	AND R2,R2,#0
	ADD R2,R2,R3
	ADD R2,R2,#-1
	AND R1,R1,#0
	ADD R1,R1,R4
	AND R4,R4,#0

LOOP1
	ADD R4,R0,R0
	ADD R2,R2,#0
	BRz DONE1
LOOP2
	ADD R6,R6,#-1
	BRz LATER
	ADD R4,R4,R1
	BRnzp LOOP2
LATER
	ADD R2,R2,#-1	
	AND R6,R6,#0
	ADD R6,R6,R4
	AND R4,R4,#0
	Brnzp LOOP1
CHANGE
	NOT R4,R4
	ADD R4,R4,#1
	BRnzp START1
DONE1
	AND R0,R0,#0
	ADD R0,R0,R6
	JSR PUSH

ODDEXP	
	ADD R4,R4,#0
	BRn ODDCHANGE
ODDSTART1
	AND R0,R0,R0
	ADD R0,R4,R4
ODDSTART2
	AND R2,R2,#0
	ADD R2,R2,R3
	ADD R2,R2,#-1
	AND R1,R1,#0
	ADD R1,R1,R4
	AND R4,R4,#0

ODDLOOP1
	ADD R4,R0,R0
	ADD R2,R2,#0
	BRz ODDDONE
ODDLOOP2
	ADD R6,R6,#-1
	BRz ODDLATER
	ADD R4,R4,R1
	BRnzp ODDLOOP2
ODDLATER
	ADD R2,R2,#-1	
	AND R6,R6,#0
	ADD R6,R6,R4
	AND R4,R4,#0
	Brnzp ODDLOOP1
ODDCHANGE
	NOT R4,R4
	ADD R4,R4,#1
	AND R5,R5,#0
	ADD R5,R5,#-1
	BRnzp ODDSTART1
ODDDONE
	ADD R5,R5,#1
	Brzp NEXT
	NOT R6,R6
	ADD R6,R6,#1

NEXT
	AND R0,R0,#0
	ADD R0,R0,R6
	JSR PUSH
RETURN6	
	LD R7,EXPSAVE_R7
	LD R3,EXPSAVE_R3
	LD R4,EXPSAVE_R4
	LD R2,EXPSAVE_R2		
	RET

EXPSAVE_R7 .BLKW #1
EXPSAVE_R3 .BLKW #1
EXPSAVE_R4 .BLKW #1
EXPSAVE_R2 .BLKW #1
EXPSAVE_R6 .BLKW #1



 
;IN:R0, OUT:R5 (0-success, 1-fail/overflow)
;R3: STACK_END R4: STACK_TOP
;
PUSH	
	ST R3, PUSH_SaveR3	;save R3
	ST R4, PUSH_SaveR4	;save R4
	AND R5, R5, #0		;
	LD R3, STACK_END	;
	LD R4, STACk_TOP	;
	ADD R3, R3, #-1		;
	NOT R3, R3		;
	ADD R3, R3, #1		;
	ADD R3, R3, R4		;
	BRz OVERFLOW		;stack is full
	STR R0, R4, #0		;no overflow, store value in the stack
	ADD R4, R4, #-1		;move top of the stack
	ST R4, STACK_TOP	;store top of stack pointer
	BRnzp DONE_PUSH		;
OVERFLOW
	ADD R5, R5, #1		;
DONE_PUSH
	LD R3, PUSH_SaveR3	;
	LD R4, PUSH_SaveR4	;
	RET


PUSH_SaveR3	.BLKW #1	;
PUSH_SaveR4	.BLKW #1	;


;OUT: R0, OUT R5 (0-success, 1-fail/underflow)
;R3 STACK_START R4 STACK_TOP
;
POP	
	ST R3, POP_SaveR3	;save R3
	ST R4, POP_SaveR4	;save R3
	AND R5, R5, #0		;clear R5
	LD R3, STACK_START	;
	LD R4, STACK_TOP	;
	NOT R3, R3		;
	ADD R3, R3, #1		;
	ADD R3, R3, R4		;
	BRz UNDERFLOW1		;
	ADD R4, R4, #1		;
	LDR R0, R4, #0		;
	ST R4, STACK_TOP	;
	BRnzp DONE_POP		;
UNDERFLOW1
	ADD R5, R5, #1		;
DONE_POP
	LD R3, POP_SaveR3	;
	LD R4, POP_SaveR4	;
	RET


POP_SaveR3	.BLKW #1	;
POP_SaveR4	.BLKW #1	;
STACK_END	.FILL x3FF0	;
STACK_START	.FILL x4000	;
STACK_TOP	.FILL x4000	;


.END
