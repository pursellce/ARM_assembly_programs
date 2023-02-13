Author: Connor Pursell
Date: 3/11/22

README
	Program Description: Takes double precision floating number (x) and a number of terms (a)
	then calculates the cosine approximation
		
	
	Registers Used:
	X0:	 incremented n value in cosine function
	D1:	 double floating point precision (x) value in cosine function
	X2:  nuber of terms (a) value in cosine function
	X3:  exponent power value in intpower and power functions
	D4:  exponent base value in power function
	D5:  exponent result value in intpower and power functions
	X6:  (n) value for factorial function
	X7:  result value for factorial function
	D8:  result of cosine function
	X9:  (-1) constant value for cosine function
	X10:  result of loop check for intpower function
	X11:  i value for loops
	X12:  (a) address for cosine function
	X13:  (x) address for cosine function
	X14-18: unused
	X19:  result of loop check for cosine loop
	D20:  (-1)^n result in cosine function
	X21:  (2n) value in cosine function
	D22:  (x^2n) result in cosine function
	X23:  (2n!) result for cosine function
	D23:  float value of (2n!) for cosine function
	X24:  Result of ((-1)^n)*(x^2n) for cosine function
	D25:  Result of (((-1)^n)*(x^2n))/2n!) to be added to overall result in cosine function
	