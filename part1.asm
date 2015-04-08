#Hien Vo
#COMP3410
#Spring 2015
#Programming Assignment #3 (PA3)
#Assigned: 4/1/15
#Deadline: 4/8/15

.data
	array: .word 4, 9, 6, 7, 10, 4, 7, 25, 26, 30, 1, 3, 4, 5, 6, 10, 20, 25, 100, 12, 15

.text
	la $s1, array  #load address of the array into s1 and s6
	la $s6, array
	
	lw  $s2, 0($s1) # load word (s1+0) into s2 so s2 will give me hazard if I use
	lw  $s5, 16($s6) # load word (s6+16) into s5, so at this point s5 will give me hazard if I use
	addi $s4, $s4, 10 # I used s4 to avoid hazard 
	sub $s6, $s1, $s2 
	add $s6, $s5, $s2 # the pipe flushed here, so it's not hazard
	or $s3, $s6, $zero # the pipe flushed here, so it's not hazard
	subi $s5, $s4, 4
	sw $s6, 12($s1) 
	#exit system call	
	li $v0, 10		# system call code for exit
	syscall				# call operating sys
