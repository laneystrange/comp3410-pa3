#Justin Hiller
#Comp 3410
#Programming Assignment 3
#Problem 1

	.data

array1:		.word	1,2,3,4,5,6	#Creates the arrays necessary for the program to run
array2:		.word 	7,8,9,10,11

	.text
	la  $s1, array1		#Loads the array into $s0
	la  $s6, array2		#Loads the second array into $s6
	
	#Code for Problem 1
	
	lw  $s2, 0($s1)
	addi $s4, $s4, 10	#Moved this here to create a buffer between $s1 uses
	lw  $s1, 16($s6)	
	subi $s5, $s4, 4	#Moved here to also add another buffer between $s1 uses
	sub $s6, $s1, $s2	
	add $s6, $s2, $s2
	
	nop			#Added null operations as a buffer from the branch operation
	nop
	nop
	
	or  $s3, $s6, $zero	#Unable to avoid hazard
	sw  $s6, 12($s1)
	
	li      $v0, 10              # terminate program run and
    	syscall                      # Exit
	
	
