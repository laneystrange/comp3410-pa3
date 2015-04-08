# Robert L. Edstrom
# COMP3410 PA3
# Problem Two
# 4/7/15

# This program will calculate the exponent of a floating point number where the exponent is an integer
# Input: a floating point number and an integer
# Output: the result of the floating point number calculated to it's exponent

		.data
	
float:		.asciiz		"\nEnter a floating point value: "
exponent:	.asciiz		"Enter an integer value(exp): "
answer:		.asciiz		"The answer is: "

		.text

inputDecimal:
		la 	$a0, float		# Load the address for the float message
		li	$v0, 4			# Setup to print the float message
		syscall				# Print the float message
		
		li	$v0, 6			# Setup for accepting a float value from the user
		syscall				# Prompt user for input i.e. the floating point value
		add.s	$f12, $f1, $f0		# Add single precision floating point value to $f12

inputExponent:		
		la	$a0, exponent		# Load the address for the exponent message
		li	$v0, 4			# Setup to print the exponent message
		syscall				# Print the exponent message
		
		li	$v0, 5			# Setup for accepting an integer value from the user i.e. the exponent
		syscall				# Prompt user for input i.e. the integer exponent
		move	$t0, $v0		# Moved the integer exponent value to register $t0
		
		bgez 	$v0, calPosExponent	# Check: is the exponent greater than or equal to zero, if so calPosExponent
		bltz 	$v0, fpNegCalculations	# Check: is the exponent less than zero, if so jump to fpNegCalculations
						# branch to fpNegCalculations is a work around for off by one exponent(neg) calculation
		
calPosExponent:
		addi	$t0, $t0, -1		# Decrement the exponent by one
		blez 	$t0, printFp		# Check: if the exponent is less than or equal to zero, were done... printFp
		j fpPosCalculations 		# Jump to fpPosCalculations
		
fpPosCalculations:				
		mul.s	$f12, $f12, $f0		# Floating point value * floating point value
		j calPosExponent		# Jump back to calculate exponent
		
calNegExponent:
		beqz	$t0, printFp		# Check: if the negative exponent is equal to zero... were done, printFp
		addi	$t0, $t0, 1		# Increment the exponent by one
		j fpNegCalculations		# Jump to fpNegCalculations
		
fpNegCalculations:
		div.s	$f12, $f12, $f0		# Floating point value / floating point value
		j calNegExponent		# Jump back to calNegExponent
		
printFp:
		la	$a0, answer		# Load the address for the answer message
		li	$v0, 4			# Setup for printing the answer message
		syscall				# Print the answer message
		
		li	$v0, 2			# Setup for printing the floating point value
		syscall				# Print the floating point value
		
exit:
		li $v0, 10			# Setup for clean exit
		syscall				# Exit 
		
		
		



