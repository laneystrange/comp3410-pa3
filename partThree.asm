.data

welcome:	.asciiz " Welcome to the sqrt program \n please enter a number to take the sqrt of:  "
answer:		.asciiz " The sqrt of the input is:  "

.text

	li $v0, 4		#prep syscall to print a string
	la $a0, welcome		#prep string to be printed
	syscall			#print the welcome string
	
	li $v0, 7		#prep syscall to recieve double input
	syscall			#take a double as user input
	

	
	cvt.w.d $f2, $f0	#convert the user entered double into an integer 
	
	mfc1.d  $t4, $f2	#MOVE THE INteger into the correct proccessor
	
	
	
	
	li $s1, 1		#set s1 to 1
	ble $t4, 2, print	#check if f1 is 2 or less than 2 if so print 1 as sqrt
	addi $s1, $s1, 1	#increment s1 to 2
	
	
	
sqrt:		
	addi $s1, $s1, 1	#increment s1 by 1
	mul $t1, $s1, $s1	#t1 = s1 squared
	beq $t1, $t4, print	#branch if the sqrt has been found
	blt $t1, $t4, lt	#branch if the sqrd number is less than the original number
gt:	
	sub $t2, $t1, $t4	#find difference between current number and goal
	
	blt	$t2, $t3, print	#branch if its closer than last value
	
	addi	$s1, $s1, -1	#decrement sqrt if nessecar 
		
	j print			#call print subroutine
	
lt:	sub	$t3, $t4, $t1	#find difference between the two numbers

	j sqrt			#loop sqrt subroutine
	
	
	

print:
	li $v0, 4		#prep syscall to print a string
	la $a0, answer		#prep string to be printed
	syscall			#print answer string
	
	li $v0, 1		#prep syscall to print int answer
	move $a0, $s1		#prep value of int for print	
	syscall			#print the integer approx of the sqrt

exit:
	li $v0, 10		#prep syscall for the exit
	syscall			#exit the program
