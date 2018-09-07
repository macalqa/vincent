.ORIG x3000
; Write code to read in characters and echo them
; till a newline character is entered.  
START 
      ST R7,SAVE_R7    
      ADD R5,R5,#1
      BRz FAIL
      AND R2,R2,#0
      LD R2,SPACE  
      NOT R2,R2
      ADD R2,R2,#1
      ADD R2,R2,R0
      BRz START
      AND R2,R2,#0
      LD R2,NEW_LINE
      NOT R2,R2    
      ADD R2,R2,#1
      ADD R2,R2,R0
      BRz CHECK_R0
      JSR IS_BALANCED
      
 
SPACE           .FILL x0020
NEW_LINE        .FILL x000A
CHAR_RETURN     .FILL x000D
SAVE_R7         .BLKW #1
STR_START	.FILL STRING	; string starting address
STRING	        .STRINGZ "((()))"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if ( push onto stack if ) pop from stack and check if popped value is (
;input - R0 holds the input
;output - R5 set to -1 if unbalanced. else not modified.
IS_BALANCED	
	AND R2,R2,#0
	LD  R2,NEG_OPEN
	ADD R2,R2,RO
	BRz PUSH
	BRnzp POP

PUSH_R0	JSR PUSH
	AND R5,R5,#0
	BRnzp RETURN

POP_R0  JSR POP
	AND R5,R5,#0
	BRnzp RETURN

RETURN  LD R7,SAVE_R7
	LD R1,R0
	RET
		
CLOSE_PAR .FILL x0029
OPEN_PAR  .FILL x0028
NEG_OPEN  .FILL xFFD8
NEG_CLOSE .FILL xFFD9
;IN:R0, OUT:R5 (0-success, 1-fail/overflow)
;R3: STACK_END R4: STACK_TOP
;
PUSH
        ST R3, PUSH_SaveR3      ;save R3
        ST R4, PUSH_SaveR4      ;save R4
        AND R5, R5, #0          ;
        LD R3, STACK_END        ;
        LD R4, STACk_TOP        ;
        ADD R3, R3, #-1         ;
        NOT R3, R3              ;
        ADD R3, R3, #1          ;
        ADD R3, R3, R4          ;
        BRz OVERFLOW            ;stack is full
        STR R0, R4, #0          ;no overflow, store value in the stack
        ADD R4, R4, #-1         ;move top of the stack
        ST R4, STACK_TOP        ;store top of stack pointer
        BRnzp DONE_PUSH         ;
OVERFLOW
        ADD R5, R5, #1
        RET                      ;
DONE_PUSH
        LD R3, PUSH_SaveR3      ;
        LD R4, PUSH_SaveR4 
	RET


PUSH_SaveR3     .BLKW #1        ;
PUSH_SaveR4     .BLKW #1        ;


;OUT: R0, OUT R5 (0-success, 1-fail/underflow)
;R3 STACK_START R4 STACK_TOP
;
POP
        ST R3, POP_SaveR3       ;save R3
        ST R4, POP_SaveR4       ;save R3
        AND R5, R5, #0          ;clear R5
        LD R3, STACK_START      ;
        LD R4, STACK_TOP        ;
        NOT R3, R3              ;
        ADD R3, R3, #1          ;
        ADD R3, R3, R4          ;
        BRz UNDERFLOW           ;
        ADD R4, R4, #1          ;
        LDR R0, R4, #0          ;
        ST R4, STACK_TOP        ;
        BRnzp DONE_POP          ;
UNDERFLOW
        ADD R5, R5, #1
	RET                     ;
DONE_POP
        LD R3, POP_SaveR3       ;
        LD R4, POP_SaveR4       ;
        RET


POP_SaveR3      .BLKW #1        ;
POP_SaveR4      .BLKW #1        ;
STACK_END       .FILL x3FF0     ;
STACK_START     .FILL x4000     ;
STACK_TOP       .FILL x4000     ;

FAIL		AND R5,R5,#0
		ADD R5,R5,#-1
		BRnzp DONE

CHECK_R1	AND R2,R2,#0
		LD R2,NEG_OPEN
		ADD R2,R2,R1
		Brz FAIL
		BRnp DONE
			
	
DONE HALT
.END

