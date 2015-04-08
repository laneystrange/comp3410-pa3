# hazards.ask

.data
	list: .word 3, 5, 1, 0, 4, 6, 2, 5, 6, 1, 2, 1, 5, 93, 82, 50, 185, 1, 5, 25

.text
	la $s1, list
	la $s6, list
	
	lw  $s2, 0($s1) # s2 is hot
	lw  $s5, 16($s6) #s5 is hot
	addi $s4, $s4, 4 # use s4
	add $s6, $s2, $s2 # use s2, s6 is hot
	sub $s6, $s5, $s2 # use s5, s2, s6 is hot
	sw $s6, 12($s1) # use s1, s6 is hot
	or $s3, $s6, $zero # use s6, s3 is hot
	
	li $v0, 10
	syscall