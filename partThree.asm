# COMP3410
# Spring 2015
# Programming Assignment #3 (PA3)
# Assigned: 4/1/15
# Deadline: 4/8/15

############## 
# Part Three #
##############

.data
Zero:
	.double 0 
Welcome:
	.asciiz "\Hello, I am Jarvis. I can help you compute the approximate sqaure root for a given floating point number.\n"
Ask_Input_X:
	.asciiz "\Please enter x (where x is a floating-point number):\n"
Tell_Output:
	.asciiz "\Your solution is: "
	
.text

# Prompt User / Read Values

main:

	# Welcome Message
	la $a0, Welcome
	li $v0, 4
	syscall
	
again:	# Asks User for X value
	la $a0, Ask_Input_X
	li $v0, 4
	syscall
	
	# Read X value
	li $v0, 7
	syscall
	
	# Store X value
	# Don't have to store, result is already placed in $f0
	# But, do want to make a copy so that we don't change X
	add.d $f2, $f2, $f0
	
	# Make sure valid input
#	l.d $f4, Zero
#	c.lt.d $f4, $f0
#	bc1t again

# Invoke Square Root Subroutine

	j squareRoot

	# Output message
return:	la $a0, Tell_Output
	li $v0, 4
	syscall
	
	# Load solution / Print solution
	addi $a0, $t0, 0
	li $v0, 1
	syscall
	
	# Exit program
	li $v0, 10
	syscall
	
##########################
# Square Root Subroutine #
##########################

# $t0 acts as counter, i.e. 1^2 -> 2^2 -> 3^2
# $t1 acts as updating square, so its the changing 1 -> 4 -> 9

squareRoot:
		# Convert float to int
		cvt.w.d $f1, $f2
		mfc1.d $t5, $f1
		
		# While updating square < float
continue:	bgt $t1, $t5, backStep
		mul $t1, $t0, $t0
		addi $t0, $t0, 1
		j continue
		
		# Need to go back by a square
		# i.e. 4^2 > X, then have to get 3^2
backStep:	addi $t0, $t0, -1
		addi $t0, $t0, -1
		mul $t1, $t0, $t0
		j return
