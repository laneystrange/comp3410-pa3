.data
	prompt:		.asciiz "Please enter a number for which you'd like the nearest integer square root:"
	result:		.asciiz "Nearest integer square root: "
	whups:		.asciiz "Negative number provided--sorry can't do imaginary junt."
	
.text
	li $v0, 4
	la $a0, prompt
	syscall

	li $v0, 7
	syscall
	
	#if float provided is negative, fail
	c.lt.d $f0, $f14
	bc1t fail

sqrt:
	#multiply the value in s0 by itself and store the double precision value in f1
	mul $s1, $s0, $s0
	mtc1 $s1, $f2
	cvt.d.w $f2, $f2

	#if the square of the number in s0 is equal to the number given by the user, we're done
	c.eq.d 0, $f2, $f0	
	bc1t 0, done

	#if the square of the number in s0 is greater than the number given by the user, we went over
	c.lt.d 1, $f2, $f0
	bc1f 1, wentover

	#increment s0 and try again
	addi $s0, $s0, 1
	j sqrt
	
done:

	#print result and exit
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	move $a0, $s0
	syscall

	li $v0, 10
	syscall

wentover:
	#subtract one from the last squared number and we're done
	subi $s0, $s0, 1
	j done
	
fail:
	li $v0, 4
	la $a0, whups
	syscall
	li $v0, 10
	syscall