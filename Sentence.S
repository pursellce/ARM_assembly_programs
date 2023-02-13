# Author: Connor Pursell
# Description: Given a user entered sentence, capitalizes the first
# letter of each word and counts the number of words in the sentence and prints
# results.
   .data
   .type	v, %object

s:
    .asciz "hello there what is your name?"


    .text
    .global main
    .arch armv8-a+fp+simd
    .type main, %function

firstchar:
	SUB 	SP, SP, #32			//create space on stack
	STUR	X9,[SP,#16]			//Push X9
	STUR	W10,[SP,#8]			//Push W10
	STUR 	X19, [SP, #0]		//push X19
	MOV		X19, #0				// X19 = i =0
	MOV		X20, #1				//X20 = wordcount = 1

	ADD 	X9, X19, X0     	// X9 = addr of s[i]
    LDURB 	W10, [X9, #0] 		// W10 = s[i]

check1:
	CMP 	W10, #97			//check s[i]
	B.GE	check2				//s[i]>= 'a' -> next check

check2:
	CMP		W10, #122			//s[i]<= 'z' ->change to captial
	B.LE	change

change:
	SUB 	X10, X10, #32		//s[i] - 32
	LDUR	X9, [SP, #16]		//restore saved X9
	LDUR 	W10,[SP,#8]			//restore new X10
	B		loop

loop:
	ADD 	X19, X19, #1		//++i
	ADD 	X9, X19, X0			//X9 = address of s[i]
	LDURB	W10, [X9, #0]		//X10 = s[i]
	CBZ		W10, cleanup			//if s[i] == 0, exit
	SUB		W11, W10, #32		//check if s[i] == space
	CBZ		W11, loop2
	B		loop

loop2:
	ADD		X20, X20, #1		//incremenet wordcount
	ADD		X19, X19, #1		//move to next character
	ADD 	X9, X19, X0			//X9 = address of s[i]
	LDURB	W10, [X9, #0]		//W10 = s[i]
	B		check1

cleanup: 
	LDUR X9,[SP,#16]    // restore saved X9
    LDUR W10,[SP,#8]    // restore saved W10
    LDUR X19,[SP,#0]    // restore saved X19
    ADD SP,SP,#32       // pop 3 item from stack
	B 	Exit




main:
	ADRP X0, s
	ADD X0, X0, :lo12:s

	BL firstchar

Exit:
