# Robert L. Edstrom
# COMP3410
# Problem One
# 4/8/15


	.data

arrayOne:	.word	1, 5, 2, 3
arrayTwo:	.word	6, 7, 8, 9, arrayOne


	.text
	
init: 	
	la $s1, arrayOne	# Load the address of arrayOne into $s1
	la $s6, arrayTwo	# Load the address of arrayTwo into $s6
		
	lw  $s2, 0($s1)
	lw  $s1, 16($s6)
	sub $s6, $s1, $s2
	addi $s4, $s4, 10	# Moved here to mitigate the read and write from register $s6
	add $s6, $s2, $s2
	subi $s5, $s4, 4	# Moved here to mitigate the read and write from register $s6
	or  $s3, $s6, $zero
	sw  $s6, 12($s1)

exit:
	li $v0, 10		# Setup for clean exit
	syscall			# Exit