# Author: Tam Duong
# Assignment: PA3#3
# Date: 4/8/15

	.data
	
Intro: 	.asciiz "Calculate square root of floating number(double precision).\n"
Prompt:	.asciiz "Enter a floating-point number(double precision):"
Answer:	.asciiz "Result is "
float0:	.double 0.0
result:		.word 0:100

	.text
	
### print Intro, Prompt and load addresses ###
la $a0, Intro
li $v0, 4
syscall
ldc1 $f2, float0($0)		# $f2 = 0.0
Repeat:	la $a0, Prompt
	li $v0, 4
	syscall
	li $v0, 7		# $f0 = foating-point number
	syscall
	c.lt.d $f0, $f2		# if $f0 < $f2 then code = 1 else code = 0
	bc1t Repeat		# if code == 1 then jump to Repeat
la $t1, result


### calculate ###
li $t0, -1			# $t0 = result
Square:	addi $t0, $t0, 1
	mul $t2, $t0, $t0		
	addi $t1, $t1, 4
	sw  $t2, 0($t1)		# $t1 = stack from $t0 square
	mtc1 $t2, $f2		# $f2 = $t2 now
	cvt.d.w $f8, $f2	# $f8 = double precision of $f2
	c.lt.d $f8, $f0		# if $f8 < $f0 then code = 1 else code = 0
	bc1t Square		# if code == 1 then jump to Square
	
lw $t2, 0($t1)
mtc1 $t2, $f2
cvt.d.w $f6, $f2		# $f6 = upper bound
sub.d $f6, $f0, $f6
abs.d $f6, $f6
addi $t1, $t1, -4
lw $t2, 0($t1)
mtc1 $t2, $f2
cvt.d.w $f4, $f2		# $f4 = lower bound
sub.d $f4, $f0, $f4
abs.d $f6, $f6
c.lt.d $f4, $f6			# if $f4 < $f6 then code = 1 else code = 0
bc1f Exit			# if code == 0 then jump to Exit
subi $t0, $t0, 1

### print result and exit ###
Exit:	la $a0, Answer
	li $v0, 4
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall	