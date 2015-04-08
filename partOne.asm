# COMP3410
# Spring 2015
# Programming Assignment #3 (PA3)
# Assigned: 4/1/15
# Deadline: 4/8/15

############ 
# Part One #
############

.data

array:
	.word 3, 0, 1, 2, 6, -1, 10
array2:
	.word -2, 4, 7, 3, 8, 9, 11
	
.text
	
#	Original Code

#	lw $s2, 0($s1)
#	lw $s1, 16($s6)
#	sub $s6, $s1, $s2
#	add $s6, $s2, $s2
#	or $s3, $s6, $zero
#	sw $s6, 12($s1)
#	addi $s4, $s4, 10
#	subi $s5, $s4, 4

#	Modified Code

	# Load arrays
	la $s1, array
	la $s6, array2

	lw $s2, 0($s1)
	lw $s1, 16($s6)	
	
	# Switched following 2, so that $s1 isn't awaiting the lw
	add $s6, $s2, $s2
	sub $s6, $s1, $s2
	
	# Unfortunately can't fix anything here...
	or $s3, $s6, $zero
	sw $s6, 12($s1)
	
	# Switched following 2, so that $s4 isn't awaiting the addi
	subi $s5, $s4, 4
	addi $s4, $s4, 10
	
	# Print results
	addi $a0, $s4, 0
	li $v0, 1
	syscall
	
	addi $a0, $s5, 0
	li $v0, 1
	syscall
	
	# Close program
	li $v0, 10
	syscall
	
# Only able to make 2 fixes. These helped avoid 2 no-ops! But, couldn't prevent the
# no-op that will occur between lines 27 and 29 (sub $s6... and or $s3 -> the or
# has dependency on $s6.	
