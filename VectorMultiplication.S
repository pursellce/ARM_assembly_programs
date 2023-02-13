# Author: Connor Pursell
# Program Description: Given two vectors containing the first five odd
# numbers and first five even numbers, performs vector multiplication and
# prints result.

   .data
  # .type	v, %object
o:
	.xword	1, 3, 5, 7, 9
e:
	.xword 2, 4, 6, 8, 10

	.text
	.global main
	.arch armv8-a+fp+simd
	# .type main, %function

main:
	ADRP	X0, e
	ADD		X0, X0, :lo12:e			//load even array
	ADRP	X1, o
	ADD		X1, X1, :lo12:o			//load odd array
	ADD		X2, XZR, XZR			//X2 = i = 0
	ADD		X3, XZR, XZR			//X3 = sum = 0
	
loop:
	SUB 	X4, X2, #5					// i-5
	CBZ		X4, exit					//if i-5=0, end loop
	
	ADD 	X6, X0, X2, LSL #3				//e[i]
	LDUR	X8, [X6, #0]					//load e[i] into X8
	
	ADD		X5, X1, X2, LSL #3				//o[i]
	LDUR	X7, [X5, #0]					//load o[i] into X7
	MUL		X10, X7, X8						// e[i]*o[i]
	ADD 	X3, X3, X10						//Add to sum
	
	ADD 	X2, X2, #1							//i++
	B		loop
	
exit:	
	
	