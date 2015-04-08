.data
	array: .word 1, 2, 3, 4, 5
.text
	la $s1, array
	la $s6, array
	la $t0, array
	sw $t0, 16($s6)

	lw $s2, 0($s1)
	addi $s4, $s4, 10
	lw $s1, 16($s6)
	sub $s6, $s1, $s2
	subi $s5, $s4, 4
	add $s6, $s2, $s2
	sw $s6, 12($s1)
	or $s3, $s6, $zero
	
	# I do want to note that "lw $s1, 16($s6)" requires that the 5th element of $s6 is an array address.
	# The four lines at the top are required to make the code work; otherwise there are array-not-found issues.