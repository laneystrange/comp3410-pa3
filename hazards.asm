.data

first: .word 8, 10, 12, 4, 7
sec: .word 100, 20, 5, 8, 2, 6, 99

.text

	la $s1, first
 	la $s6, sec
 	
 	lw  $s2, 0($s1)
 	addi $s4, $s4, 10 # moved a bit farther away from the next calculation
	lw  $s7, 16($s6)  #error s1 is called as an array when this turns it into a int
	sub $s6, $s7, $s2

	add $s6, $s2, $s2
	or  $s3, $s6, $zero

	sw  $s6, 12($s1)
	subi $s5, $s4, 4
	
	li $v0, 10
	syscall