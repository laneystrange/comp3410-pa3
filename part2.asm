# Author: Tam Duong
# Assignment: PA3#2
# Date: 4/8/15

	.data
	
Prompt: 	.asciiz "Calculate x^k.\nEnter the value for x and k (x is floating-point number, k is integer):\n"
Answer:		.asciiz "Result is "
float1:		.float 1.0

	.text
	
### print prompt ###
la $a0, Prompt
li $v0, 4
syscall

### read, store user inputs and also load other inputs ###
li $v0, 6
syscall				# $f0 = x
li $v0, 5
syscall
move $s0, $v0			# $s0 is k (orginal copy)
move $t0, $s0			# $t0 is k (will be change as exponent decrease)
mov.s $f1, $f0			# $f1 = copy of x so $f0 can constantly be change
lwc1 $f3, float1($0)		# $f3 = 1.0

### calculation ###
beqz	$s0, kisZero
abs $t0, $t0			
subi $t0, $t0, 1		# decrease exponent by 1 so when it get to x^1 it won't double 1 more time
Power:	beqz $t0, SkipPow
	mul.s $f0, $f0, $f1
	subi $t0, $t0, 1
	j Power
		
SkipPow:	bgtz $s0, Exit			# when k is 1 then we can go straight here
		div.s $f0, $f3, $f0

### print result and exit ###
Exit:	la $a0, Answer
	li $v0, 4
	syscall
	li $v0, 2		# print single precision
	mov.s $f12, $f0
	syscall
	li $v0, 10
	syscall
	
### k is zero ###
kisZero:	mov.s $f0, $f3
		j Exit
