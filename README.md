### Claire Skaggs
##### COMP 3410
##### Programming Assignment 3

###### PART ONE

My answer to part one is located in partone.asm.

Some of the hazards in this program can be solved by operand forwarding, others I have prevented by reorganizing the instructions.

These are my changes to avoid data hazards:
1. The instruction 'addi $s4, $s4, 10' was moved between the instructions 'lw $s2, 0($s1)' and 'lw $s1, 16($s6)'. In this
way it acts as a buffer for the pipeline stages trying to write to and read from the value in register $s1.
2. The instruction 'subi $s5, $s4, 4' was moved between the instructions 'sub $s6, $s1, $s2' and 'add $s6, $s2, $s2'. In this
way it acts as a buffer for the pipeline stages trying to write to and read from the value in register $s6.
3. The instruction 'sw $s6, 12($s1)' was moved between the instructions 'add $s6, $s2, $s2' and 'or $s3, $s6, $zero'. In this
way it acts as a buffer for the pipeline stages trying to write to and read from the value in register $s6.

###### PART TWO

My answer to part two is located in parttwo.asm.

Sample Output:

	This program calculates x^k, where x is a floating point and k is an integer. 
	Enter x (floating point value): 2.8
	Enter k (integer value): 3
	x^k = 21.952

	This program calculates x^k, where x is a floating point and k is an integer. 
	Enter x (floating point value): 15.3
	Enter k (integer value): 2
	x^k = 234.09001
	
	This program calculates x^k, where x is a floating point and k is an integer. 
	Enter x (floating point value): 4.6
	Enter k (integer value): 5
	x^k = 2059.6296
	
	This program calculates x^k, where x is a floating point and k is an integer. 
	Enter x (floating point value): 12.2
	Enter k (integer value): 4
	x^k = 22153.344

###### PART THREE

My answer to part three is located in partthree.asm.

Sample Output:
	This program approximates the nearest integer square root of a floating point number. 
	Enter your floating point number: 16.5
	The approximate result is: 4

	This program approximates the nearest integer square root of a floating point number. 
	Enter your floating point number: 16
	The approximate result is: 4
	
	This program approximates the nearest integer square root of a floating point number. 
	Enter your floating point number: 37.6
	The approximate result is: 6
	
	This program approximates the nearest integer square root of a floating point number. 
	Enter your floating point number: 36
	The approximate result is: 6