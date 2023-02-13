# Author: Connor Pursell
# Date: 2/9/22
# Program Description: Given the first two Fibonacci numbers, 
# calculates the next eight in the series, and prints.

.data
	.type	v, %object
	.size	v, 10


v:
	.xword	0, 1, 0, 0, 0, 0, 0, 0, 0, 0

	.text
	.global main
	.arch armv8-a+fp+simd
	.type main, %function

main:
	ADRP	X0, v
	ADD		X0, X0, :lo12:v
	MOV		X19, #0					//X19 = i = 0

loop:
	SUB 	X20, X19, #10			//i-10
	CBZ		X20, Exit				//if i=10 break

	ADD		X5, X0, X19, LSL #3		//x[i]
	LDUR	X1, [X5, #0]			//X1= x[i]
	ADD		X19, X19, #1			//++i
	ADD		X6, X0, X19, LSL #3		//x[i+1]
	LDUR	X2, [X6, #0]			//X2= x[i+1]
	ADD 	X3, X1, X2				//X3 = x[i] + x[i+1]
	ADD 	X19, X19, #1			//++i
	MOV		X8, #8					//X8=8
	MUL		X7, X19, X8				//X7 = i*8/ calculate appropriate shift
	STR		X3, [X0, X7]			//store x3 in x[i+2] using i*8
	SUB		X19, X19, #1			//i-1
	B		loop

Exit:



