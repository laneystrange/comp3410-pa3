Robert L. Edstrom
COMP3410
PA3
4/7/15

Problem 2:

	Input: A float value(x) and an integer (y)
	Output: x ^ y

	Output:
		Run 1: 
			Enter a floating point value: 2.0
			Enter an integer value(exp): 5
			The answer is: 32.0

		Run 2: 
			Enter a floating point value: -2.0
			Enter an integer value(exp): 3
			The answer is: -8.0

		Run 3:
			Enter a floating point value: 2.0
			Enter an integer value(exp): -4
			The answer is: 0.0625

		Run 4: 
			Enter a floating point value: -2.0
			Enter an integer value(exp): -4
			The answer is: 0.0625

	Summary: 
		If a negative exponent is entered by the user the program has
		to jump straight into fpNegCalculations. Otherwise, the result 
		would be incorrect due to being off by 1 division.

Problem 3:

	Input: A float value
	Output: The sqrt of the float value

	Output:

		Run 1: 
			Enter a floating point value: 22.05
			The answer is:	4.695752

		Run 2: 
			Enter a floating point value: 4.0
			The answer is:	2.0

		Run 3: 
			Enter a floating point value: 555.0
			The answer is:	23.558437

		Run 4: 
			Enter a floating point value: 66.6
			The answer is:	8.160885

	Summary: 
		This one was tricky to solve at first until I came across 
		Newton's Method to calculate the sqrt. Then the trick was
		to implement the C code I found into MIPS. 
