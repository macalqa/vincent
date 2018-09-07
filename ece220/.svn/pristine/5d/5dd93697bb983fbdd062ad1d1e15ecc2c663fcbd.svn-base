.ORIG x3000
AND R0, R0, #0;
AND R1, R1, #0
ADD R1, R1, #2
JSR BITSWAP
LEA R0, RETURNED
PUTS
HALT

RETURNED .STRINGZ "Successfully Returned\n"
; x3000

LD R2, STRSTART

LOOP
LDR R0, R2, #0
BRz FINISH		; We are done when we hit NULL
LD R1, BITMASK
JSR BITSWAP		; Do the bitswap
STR R0, R2, #0		; Writes back to the original location
ADD R2, R2, #1
BRnzp LOOP 
FINISH 
HALT

STRSTART .FILL x4000
BITMASK .FILL x0003	; set n = 3

;Do not touch or change and code above this line
;---------------------------------------------
;You must not change the separation line above
;Please write ALL your code for BITSWAP in between the separations lines,
;including all the labels, code, and .FILL commands

 
;Subroutine to swap bits
;Input: 
;R0: the ascii that to be swapped 
;R1: the number of bits to be swapped
; You can assume R1 is always 0, 1, 2, or 3
;Output: R0, the swapped ascii
BITSWAP
;;YOUR CODE STARTS HERE
ST R2,SAVE_R2
ST R4,SAVE_R4
ST R3,SAVE_R3
ST R5,SAVE_R5
ST R6,SAVE_R6
ST R1,SAVE_R1
ST R7,SAVE_R7
AND R2,R2,#0
ADD R2,R2,R0
JSR EXTRACT
AND R3,R3,#0
ADD R3,R3,R0
AND R4,R4,#0
AND R5,R5,#0
ADD R5,R5,#8
AND R6,R6,#0
ADD R6,R6,R1
NOT R6,R6
ADD R6,R6,#1
ADD R6,R6,R5
ST R3,SAVERIGHT
LOOP3
    ADD R6,R6,#-1
    BRz NEXT2
    ADD R3,R3,R3
    BRnzp LOOP3
NEXT2
	AND R6,R6,#0
	ADD R6,R6,R2
	NOT R3,R3
	ADD R3,R3,#1
	ADD R2,R2,R3
	ST R2,RIGHTMIDDLE
	AND R2,R2,#0
	ADD R2,R2,R6
	LD R3,SAVERIGHT
	AND R0,R0,R2
	JSR EXTRACT
	AND R4,R4,#0
	ADD R4,R4,#8
	AND R6,R6,#0
	ADD R6,R6,R1
	AND R5,R5,#0
	ADD R5,R5,#8
	NOT R6,R6
	ADD R6,R6,#1
	ADD R6,R6,R5
LOOP2
	ADD R6,R6,#-1
	BRz DONE
	ADD R0,R0,R0
	BRnzp LOOP2
DONE
	AND R4,R4,#0
	ADD R4,R4,R0
	ST R2;INAL
	LD R2,RIGHTMIDDLE
	NOT R0,R0
	ADD R0,R0,#1
	ADD R2,R2,R0
	ST R2,MIDDLE
	AND R0,R0,#0
	ADD R0,R0,R4
	ADD R0,R3,R2
	LD R2,SAVE_R2
	LD R4,SAVE_R4
	LD R3,SAVE_R3
	LD R5,SAVE_R5
	LD R6,SAVE_R6
	LD R1,SAVE_R1
	LD R7,SAVE_R7
	RET



SAVERIGHT .BLKW #1
SAVE_R2 .BLKW #1
SAVE_R4 .BLKW #1
SAVE_R3 .BLKW #1
SAVE_R5 .BLKW #1
SAVE_R6 .BLKW #1
SAVE_R1 .BLKW #1
SAVE_R7 .BLKW #1
RIGHTMIDDLE .BLKW #1
MIDDLE .BLKW #1
SAV;INAL .BLKW #1
ORIGINAL .BLKW #1
;You must not change the separation line below.
;Write all your code for BITSWAP above this line
;=============================================


;DO NOT CHANGE THE GIVEN CODE BELOW
;=============================================
;;EXTRACT Subroutine (Given Code) 
;;Input: R0 - ASCII value
;;       R1 - n (between 0 and 4) bits to be extracted
EXTRACT
ST R0, SAVER1
ST R7, SAVER3
LEA R0, EXCALLED
PUTS
LD R0, SAVER1
LD R7, SAVER3
RET
EXCALLED .STRINGZ "\nEXTRACT CALLED\n"
SAVER1 .FILL #0
SAVER2 .FILL #0
SAVER3 .FILL #0
.END
