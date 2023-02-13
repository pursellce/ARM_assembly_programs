
//Author: Connor Pursell
//Date: 3/11/22
//Program Description: Takes double precision floating number (x) and a number of terms (a)
//then calculates the cosine approximation

	.data
	.type v, %object
x:
	.float 2.0
a:
	.xword 10

    .text
    .global main
    .arch armv8-a+fp+simd
  #  .type main, %function


intpower:
	MOV X25, #1				//X25 = result = 1
	MOV X11, #0	    		//X11 = i = 0
	CBZ X3, convert			//if exponent is zero, convert back to double to return 1
	B intpowerloop

intpowerloop:
	SUB X10, X3, X11		//check if i<n
	CBZ	X10, convert		//if i=n, go to convert back to double to return
	MUL X25, X25, X9		//multiply result by base (-1) stored in X9
	ADD X11, X11, #1		//i++
	B intpowerloop

convert:
	SCVTF D5, X25
	B Step2

power:
	//set up i and result variables, exponent in X3, base in D4
	MOV X11,#0	    		//X11 = i = 0
	FMOV D5, 1.0			//D5 = result = 1
	CBZ X3, powercleanup	//if exponent is zero, return 1
	B powerloop

powerloop:
	SUB X10, X3, X11		//check if i<n
	CBZ X10, powercleanup	//if i=n, go to cleanup
	FMUL D5, D5, D4      	//multiply result by base
	ADD X11, X11, #1      	//i++
	B powerloop

powercleanup:
	B Step3					//return

fact:
	MOV X11, #1				//X11=i=1
	MOV X7, #1				//X7=result=1
	ADD X6, X6, #1			//n+1 for loop check
	B factloop

factloop:
	SUB X3, X6, X11			//n-i
	CBZ X3, factcleanup		//if n-i=0, return result
	MUL X7, X7, X11			//result=result*i
	ADD X11, X11, #1		//i++
	B factloop

factcleanup:
	SUB X6, X6, #1			//restore n to previous value
	B Step4					//return

cosine:
	MOVI D8, #0				//set result = 0
	MOV X0, #0				//set X0 = n = 0
	B cosineloop			//enter cosine loop

cosineloop:
	SUB X19, X2, X0			//check a - n = X19
	CBZ	X19, exit			//if a - n = 0, exit
Step1:	//Calculate (-1)^n
	MOV X3, #0				//set x3 to 0
	ADD X3, X3, X0			//move n value to x3 for power function
	B intpower				//calculate (-1)^n, result in  D5
Step2:
	MOVI D20, #0			//set d20 to zero
	ADD D20, D20, D5		//move result of (-1)^n to D20

	//calculate x^2n
	ADD X21, X0, X0			//calculate 2n, store in X21
	MOV X3, #0
	ADD X3, X3, X21			//move 2n to X3 for power function exponent
	MOVI D4, #0				//set D4 to 0
	ADD D4, D4, D1			//move x to D4 for power function base
	B power					//calculate x^2n
Step3:
	MOVI D22, #0			//set D22 to 0
	ADD D22, D22, D5		//move result of x^2n to D22

	//calculate 2n!
	MOV X6, #0				//set X6 to 0
	ADD X6, X6, X21			//put 2n in X6 as argument for factorial function
	B fact					//call factorial function
Step4:
	MOV X23, #0				//set X23 to 0
	ADD X23, X23, X7		//move result of 2n! to X23
	SCVTF D23, X23			//convert 2n! to float

	//calculate (((-1)^n)*(x^2n))/2n!)
	FMUL D24, D20, D22		//calculate ((-1)^n)*(x^2n)
	FDIV D25, D24, D23		//divide above result by 2n!

	//Summation and increment
	FADD D8, D8, D25		//sum results
	ADD X0, X0, #1			//n++
	B cosineloop			//return to top of loop

main:
	//ADRP X13, x				//load x address into X14
	//ADD X13, X13, :lo12:x
	//LDUR D1, [X13, #0]		//load x value into D1

	FMOV D1, 2.0				//force x value into D1
	ADRP X12, a					//load a address into X2
	ADD X12, X12, :lo12:a
	LDUR X2, [X12, #0]			//load a value into X2

	MOV X9, #-1

	B cosine

exit:
	NOP

