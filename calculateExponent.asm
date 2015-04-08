.data

float:		.asciiz "Enter the floating number\n"
exponent:	.asciiz "Enter the exponent\n"
newline:	.asciiz "\n"
numberOne:	.float 1.0

.text

	la $s0 numberOne	# Create the floating point to be use in the final result.
	l.s $f2, ($s0)		# Initializied the final result
	
	la $a0, float		# Ask the user for the floating point they wish to use.
	li $v0, 4		# 
	syscall
	
	li $v0, 6		# Accept input from the user.
	syscall 
	
	la $a0, newline		# Create a new line to create space between the sentences
	li $v0, 4		# 
	syscall
	
	la $a0, exponent	# Ask the user for the exponent they wish to use.
	li $v0, 4		# 
	syscall
	
	li $v0, 5		# 
	syscall
	move $t2, $v0		# Move the exponent to t2
	
	addi $t7, $0, 0		# Set $t7 to 0 to be used as a counter in the for loop.
	
for:	bge $t7, $t2, end	# If the counter is greater or equal to the exponent than branch to end the program.
	blt $t7, $t2, loop	# If the counter is less than exponent than branch to the loop to increment the result.

loop:	mul.s  $f2, $f2, $f0	# Multiply the result by the original variable,
	addi $t7, $t7, 1	# Increment the counter
	j for			# Jump to the check to see if the new counter and the exponent are now the same.
	
end:	li $v0, 2		# 
	mov.s $f12, $f2		# 
	syscall