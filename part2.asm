# Evan Black
# Dr. Strange
# Comp 3410
# April 7th, 2014

.data
intro:		.asciiz "This program will give the result of x^k\n"
promptFloat:	.asciiz "Please input a value for x: "
promptExp:	.asciiz "Please input a value for k: "
result:		.asciiz "The result is "

fpOne:		.float	1.0

.text
li	$v0, 4			# Get ready to print
la	$a0, intro		# Adress of string to print
syscall				# Print
la	$a0, promptFloat	# Address of strin to print
syscall				# Print

li	$v0, 6			# Get ready to read float
syscall				# Read (result in $f0)

li	$v0, 4			# Get ready to print
la	$a0, promptExp		# Address of string to print
syscall

li	$v0, 5			# Get ready to read integer
syscall				# Read
move	$a0, $v0		# Move the result into our argument

jal subroutine

li	$v0, 4			# Get ready to print
la	$a0, result		# Address of string to print
syscall

li	$v0, 2			# Get ready to print a float
mov.s	$f12, $f0		# Move the float into the f12 reg (argument in this case)
syscall				# Print the float

li	$v0, 10			# Prepare to exit
syscall				# Exit

# I'm going to use f0 like v0 in this case, it will be the input and output of the subroutine
subroutine:
	addi	$sp, $sp, -8	# Ready the stack pointer
	sw	$t0, 4($sp)	# Store the value of $t0 on the stack
	s.s	$f1, 0($sp)	# Store the value of f1 on the stack

	move 	$t0, $a0	# Move the value of our exponent into t0 for work
	mov.s	$f1, $f0	# Move the value of f0 into f1 for work
	bgtz 	$t0, subloop	# If it's non-zero positive, go ahead to the loop
	neg	$t0, $t0	# If not, negate it for our decrementing
	bgtz	$t0, subloop	# If it's still not greater than zero at this point, then...
	l.s	$f0, fpOne	# The value will be 1
	jr	$ra		# Jump back
	
	subloop:
		mul.s	$f1, $f1, $f0	# Xcurrent = Xcurrent * Xoriginal
		addi	$t0, $t0, -1	# Decrement our counter by 1
		bgt	$t0, 1, subloop	# If our decremented counter is still greater than 1, then do it again
		
	subloopexit:
	bgtz	$a0, subreturn		# If our exponent was greater than 0, the go to the exit, otherwise...
	addi	$sp, $sp, -4		# Ready the stack pointer
	s.s	$f2, ($sp)		# Store the value of f2 on the stack
	l.s	$f2, fpOne		# Load the value of 1 into f2
	div.s	$f1, $f2, $f1		# Set f1 to f2/f1
	l.s	$f2, ($sp)		# Load f2's old value
	addi	$sp, $sp, 4		# Fix the stack pointer
	
	
	subreturn:
		mov.s	$f0, $f1	# Move our result into our return register
		lw	$t0, 4($sp)	# Load old t0
		l.s	$f1, 0($sp)	# Load old f1
		addi	$sp, $sp, 8	# Fix the stack pointer
		jr $ra			# Jump back