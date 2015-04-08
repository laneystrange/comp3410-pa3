.data
	arrOne: .word 2, 3, 5, 7, 11, 13, 17
	arrTwo: .word 1, 4, 6, 8, 9, 10, 12 

.text

	la	$s1, arrOne
	la	$s6, arrTwo
	
	lw	$s2, 0($s1)
	addi	$s4, $s4, 10	#moved
	lw 	$s1, 16($s6)
	sub	$s6, $s1, $s2	#moved
	subi 	$s5, $s4, 4	#moved
	add	$s6, $s2, $s2
	sw 	$s6, 12($s1)	#moved
	or 	$s3, $s6, $zero

	li	$v0, 10
	syscall	