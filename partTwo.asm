.data

hello: 	.asciiz "Hello please enter a number x: "
entery:	.asciiz	"Please enter a number k for x^k: "

answer: .asciiz	"x^k == "

.text

	li $v0, 4 		# prepare the syscall for printing a string 
	la $a0, hello		#load the hello string for the syscall
	syscall			#print the string 

	li $v0, 6		#prep syscall for recieving a float
	syscall			#take a float as input

	mov.s $f1, $f0		#move float from f0 to f1

	li $v0, 4 		#prep syscall for another print 
	la $a0, entery		#load the other message to print
	syscall			#print the other message

	li $v0, 5		#prep the syscall to take an int as user input
	syscall			#take an int from the user 
	
	move $s1, $v0		# store the int in s1

exponent:
	 beq $s1, 1, print	#print result if done with x^k
	 
	 mul.s $f1, $f1, $f0	#multiply f1 by f0 and store result in f1 
	 addi $s1, $s1, -1	#decrement s1 by 1
	 
	 j exponent		#jumpt to exponent label
	 
print:	
	la $a0, answer		#prep syscall to print final message
	li $v0, 4		#prep syscall to print final string message
	syscall			#print message 

	li $v0, 2		#prep syscall to print a float
	mov.s $f12, $f1		#move f1 to f12 for syscall
	syscall			#PRINT THE float answer

exit:	
	li $v0, 10		#prep syscall for exiting the program 
	syscall			#exit the program
