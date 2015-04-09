#Justin Hiller
#Problem 2
#Programming Assignment 3

	.data
promptFloat:	.asciiz		"Enter the Floating Point Number for x: "
promptInt:	.asciiz		"Enter the integer for k: "
printAnswer:	.asciiz		"Result of x^k: " 

	.text
	
	#Prompts
	la $a0, promptFloat	#Prepares to prompt the user for a float value
	li $v0, 4		#Prints
	syscall
	
	li $v0, 6		#Prepares for the reading of a float
	syscall			#Reads the float
	
	la $a0, promptInt	#Prepares to prompt the user for an integer value
	li $v0, 4		#Prints
	syscall
	
	li $v0, 5		#Prepares for the reading of an integer value
	syscall			#Reads the integer
	
	#Determines which function to use depending on whether or not the value is positive or negative
	move $a0, $v0		#Moves $v0 into $a0
	lui $t0, 16256		#Loads the value of 1
	mtc1 $t0, $f2		#Moves to the correct processor
	bgezal $a0, ifPositive	#jumps to loop if the int is greater than or equal to 0
	bltzal $a0, ifNegative 	#Jumps to loop if the in is less than 0
	
	#Prints the final result
	la $a0, printAnswer	#loads printAnswer into $a0
	li $v0, 4
	syscall
	
	li $v0, 2		#Prepares to print the result
	mov.s $f12, $f2		#Moves $f2 to $f12
	syscall
	j exit			#Exits the program
	
ifPositive:			#This uses recursion to calculate the power
	addi $sp, $sp, -4 	#moves the stack pointer by -4 	
	sw $ra, 0($sp)		#Stores the current value
	addi $a0, $a0, -1	#Decreases the value of the exponent by one each iteration
	beq $a0, $zero, posBaseCase	#When $a0 = 0, base case is valid and jumps to posBaseCase
	jal ifPositive

posBaseCase:
	lw $ra, 0($sp)		#retrieves the value
	addi $sp, $sp, 4	#Returns stack pointer to correct position
	mul.s $f2, $f2, $f0	#Multiplies f2 and f0 to single point precision
	jr $ra

ifNegative:			#Same as above function, uses recursion to calulate the power
	addi $sp, $sp, -4	#Moves the stack pointer to store the value
	sw $ra, 0($sp)		#Stores the current value
	addi $a0, $a0, 1	#Increments the value of the exponent because it is negative
	beq $a0, $zero, negBaseCase	#When $a0 = 0, base case is met and jumps to negBaseCase function
	jal ifNegative
	
negBaseCase:
	lw $ra, 0($sp)		#Retrieves the value
	addi $sp, $sp, 4	#Returns stack pointer to correct position
	div.s $f2, $f2, $f0	#Divides for single point precision
	jr $ra
	
exit: 	li $v0, 10		#Exits the program
	syscall
