#Justin Hiller
#Programming Assignment 3
#Problem 3

	.data
	
promptUser:	.asciiz		"Please Enter A Number Greater Than Zero: "
sqrtResult:	.asciiz		"The Square Root Integer Is: "
errorMsg:	.asciiz		"Invalid Format, Must be Greater Than Zero: "

	.text
	
	la $a0, promptUser	#Sets up to prompt the user for the number
	li $v0, 4		#Prints the prompt
	syscall
	
	li $v0, 7		#Prepares to accept the float from the user
	syscall
	
	cvt.w.d $f2, $f0	#Converts the float number to an integer
	mfc1.d  $t4, $f2	#Moves the integer to a different processor
	blez $t4, printError	#If the entered number is less than 0, jumps to error 
	
	li $s1, 1		#Loads the number 1 into $s0	
	ble $t4, 2, printAnswer	#Jumps to print the answer if the number entered is <= 2
	addi $s1, $s1, 1	#Adds $s1 + 1 = 2 	

	#Calculates the square root	
sqrtCalc:
	addi $s1, $s1, 1	#Adds an additional 1 to $s1
	mul $t1, $s1, $s1	#Multiplies $s1 x $s1 to $t1 which ends up being $s1 squared
	beq $t1, $t4, printAnswer	#If the square root has been found, then the answer is printed
	blt $t1, $t4, else	#Jumps to the else function if the squared number is less than the original

	#If the number is larger than it finds the closest number to the expected number	
if:	
	sub $t2, $t1, $t4	#Subtracts squared number - original number
	blt $t2, $t3, printAnswer	#Branches to print the answer
	addi $s1, $s1, -1		#Reduces the squared number
	jal printAnswer			#Prints the answer
	
	#Calculates the result if the squared number is less than the original
else:
	sub $t3, $t4, $t1	#Subtracts oiginal number - squared number	
	jal sqrtCalc		#Returns to the square calculater like a loop	

printAnswer:
	la $a0, sqrtResult	#Prepares to print the result message
	li $v0, 4			
	syscall			#Prints the message	
	move $a0, $s1		#Moves the value of $s1 into $a0 to prepare to print
	li $v0, 1		#Prepares to print the result 	
	syscall	
	jal exit		#Closes the program

	#Prints the error message if the user entered number is less than zero
printError:	
	la $a0, errorMsg	#Loads the error message
	li $v0, 4
	syscall			#Prints the error message	
	jal exit		#Closes the program 

exit:
	li $v0, 10		#Exits the program
	syscall			
