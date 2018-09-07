 
 ; assignment: develop a code to print a value stored in a register 
 ;             as a hexadecimal number to the monitor
 ; algorithm: turnin each group of four bits into a digit
 ;            calculate the corresponding ASCII character;
 ;            print the character to the monitor

 .ORIG x3000
		AND R2,R2,#0
		ADD R2,R2,#4 	        ;initialize digit counter
DIGIT	        ADD R2,R2,#-1 		;decrement digit counter
		BRn DONE      		;branch to DONE if 4 digits have been printed
		AND R4,R4,#0  
		AND R1,R1,#0
		ADD R1,R1,#4  		;initialize digit and bit counter
BIT		ADD R1,R1,#-1 		;decrement bit counter
		BRn FOUR      		;branch to FOUR if four bits of R3 have been "read"
		ADD R4,R4,R4  		;shifting digit left
		ADD R3,R3,#0
		BRn ONE       		;branch to ONE if R3 is less then 0
		ADD R4,R4,#0  
		ADD R3,R3,R3  		;adds 0 to digit and shifts R3 left
		BRnzp BIT     		;branches back to BIT
ONE		ADD R4,R4,#1  
		ADD R3,R3,R3  		;adds 1 to digit and shifts R3 left
		BRnzp BIT     		;branches back to BIT
FOUR    AND R5,R5,#0  
		ADD R5,R5,R4  		;initialized R5 and loaded it with the contents of R4
		ADD R5,R5,#-10 
		BRn ZERO      		;check to see if contents of R5 -10, or 'xA', is < 0
		AND R0,R0,#0
		LD  R0,Sixfive 	    ;
		ADD R0,R0,R4        ;add 65       
		ADD R0,R0,#-10		;if >= 0, R4 is subtracted by 10
		OUT			  		;then outputted to monitor
		BRnzp DIGIT
ZERO	AND R0,R0,#0
		LD R0,Zero1
		ADD R4,R4,#0  		;if R5-10 < 0 then 0 is added to R4
		ADD R0,R0,R4  		;store value of R4 into R0
		OUT           
		Brnzp DIGIT
	




Sixfive .FILL x41
Zero1	.FILL x30
		
		  
 ; stop the computer

DONE    HALT	



 ; program data section starts here


 .END

