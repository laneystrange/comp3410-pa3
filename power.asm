.data
	promptOne:	.asciiz "Enter the floating point number you'd like to find a power of: "
	promptTwo:	.asciiz "Enter the power you'd like the raise the initial number to: "
	result:		.asciiz "Result: "
	one:		.float 1
	negOne:		.float -1.0
	
.text
	l.s $f4, negOne #load negative one in f4 for later
	
	#print out first prompt and take float as input
	li $v0, 4 
	la $a0, promptOne
	syscall
	
	li $v0, 6
	syscall
	
	#print out second prompt and take integer as input
	li $v0, 4
	la $a0, promptTwo
	syscall
		
	li $v0, 5
	syscall
	
	#move user input integer to s0 
	move $s0, $v0
	
	#if user input power is negative, branch to negative
	bltz $s0, negative

cont:
	mov.s $f2, $f0	#duplicate initial float value at $f2 for later

loop:
	beq $s0, 1, done #if power is one, we're done--that is, repeat until exponent is one
	mul.s $f0, $f0, $f2 #bring value in f0 up a power
	subi $s0, $s0, 1 #subtract one from exponent
	j loop

done:
	bltz $s1, recip #if exponent was initially negative, return the reciprocal of result from loop
	
	#print result and exit
	li $v0, 4 
	la $a0, result
	syscall
	
	li $v0, 2
	mov.s $f12, $f0
	syscall
	
	li $v0, 10
	syscall
	
	
recip:
	#divide one by loop result and set negative exponent flag to 0
	l.s $f6, one
	div.s $f0, $f6, $f0
	li $s1, 0
	j done

	
negative:
	#make power positive and set a flag at $s1 indicating that it is negative
	mul $s0, $s0, -1
	li $s1, -1
	j cont #continue