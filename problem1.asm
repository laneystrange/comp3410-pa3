.data
	#array of ints 
	array1:  .word   0, 2, 4, 6, 2, 5, 3, 7, 2, 1, 4, 3, 5, 6, 7, 8, 9, 1, 1, 1,


.text
	#load the adresses into memory
	la $s1, array1
	la $s6, array1

	lw  $s2, 0($s1) 	#loads them word located in s1 with offset of 0 into s2
	lw  $s5, 16($s6)	#loads value from s6 into s1 with offset of 16
				#Data hazzard the s1 holds the adress of the array
				#xhange to s5
	addi $s4, $s4, 10	#use s4
	add $s6, $s2, $s2	#use s2
	sub $s6, $s3, $s2	#
	subi $s5, $s4, 4	#
	sw  $s6, 12($s1)	#
	or  $s3, $s6, $zero	#use s3, s6 is hot

	li $v0, 10
	syscall
