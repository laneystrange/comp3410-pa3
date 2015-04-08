# COMP3410
# Spring 2015
# Programming Assignment #3 (PA3)
# Assigned: 4/1/15
# Deadline: 4/8/15

############ 
# Part Two #
############

.data
One:
	.float 1
Welcome:
	.asciiz "\Hello, I am Jarvis. I can help you compute x^k.\n"
Ask_Input_X:
	.asciiz "\Please enter x (where x is a floating-point number):\n"
Ask_Input_K:
	.asciiz "\Please enter k (where k is an integer):\n"
Tell_Output:
	.asciiz "\Your solution is: "
	
.text

# Prompt User / Read Values

main:

	# Welcome Message
	la $a0, Welcome
	li $v0, 4
	syscall
	
	# Asks User for X value
	la $a0, Ask_Input_X
	li $v0, 4
	syscall
	
	# Read X value
	li $v0, 6
	syscall
	
	# Store X value
	# Don't have to store, result is already placed in $f0
	# But, do want to make a copy so that we don't change X
	add.s $f1, $f1, $f0
	
	# Asks User for K value
	la $a0, Ask_Input_K
	li $v0, 4
	syscall
	
	# Read K value
	li $v0, 5
	syscall
	
	# Store K value
	addi $s1, $v0, 0

# Invoke Exponent Subroutine

	j exponent

	# Output message
return:	la $a0, Tell_Output
	li $v0, 4
	syscall
	
	# Load solution / Print solution
	mov.s $f12, $f1
	li $v0, 2
	syscall
	
	# Exit program
	li $v0, 10
	syscall

#######################
# Exponent Subroutine #
#######################

exponent:
		# Determine whether k = - or +
		bgez $s1, positive
		bltz $s1, negative
		
		# Once X has been raised to positive K, we need to divide 1 by it to handle negative
negate:		l.s $f2, One
		div.s $f1, $f2, $f1
		j return
	
negative:	
		li $t0, -1
		# While $t0 > k
		# Multiply X by the previous product of X*X
loopN:		beq $t0, $s1, negate
		mul.s $f1, $f1, $f0
		sub $t0, $t0, 1
		j loopN
	
positive:	
		li $t0, 1
		# While $t0 < k
		# Multiply X by the previous product of X*X
loopP:		beq $t0, $s1, return
		mul.s $f1, $f1, $f0
		addi $t0, $t0, 1
		j loopP
