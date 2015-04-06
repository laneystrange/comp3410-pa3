# sqrrt.asm - approximates the square root of an input number
# by kevin fisher

.data
	s_intro: .asciiz "Hello, welcome to sqrrt.asm, by Kevin Fisher\n"
	s_inputd: .asciiz "Please input a number of which to find the square root: \n"
	s_result: .asciiz "The result is:\n"
	s_error: .asciiz "Your input must be greater than 0!\n"
	fp_one: .double 1
	fp_inc: .double 0.5
	fp_zero: .double 0

.text
start:
	la $a0, s_intro
	jal printstr
	jal readdouble
	
	jal square
	
	# make sure it is > 0
	l.d $f2, fp_zero
	c.le.d $f0, $f2
	bc1t error
	
	la $a0, s_result
	jal printstr
	# move result to a0
	add $a0, $t0, $0
	jal printint
	
	j exit
	
error:
	la $a0, s_error
	jal printstr
	j exit
	
square:
	# setup
	l.d $f2, fp_inc # f2 = 1, f2 is just going to store 1 forever
	l.d $f4, fp_one # f4 = 1, f4 is our current best guess
	li $t2, 0 # if a "round up" is needed, t2 will be 1
sqrlp:	add.d $f6, $f2, $f4 # f6 = f4 + 1, f6 is our next guess
	mul.d $f8, $f6, $f6 # f8 = f6^2
	c.le.d $f8, $f0	 # see if our guess is less than the target
	bc1f sqrend # if it is greater, end the loop
	mov.d $f4, $f6 # our best guess is the next integer (f4++)
	# these next two lines basically just make t2 equal 1 if its 0, and 0 if its 1
	not $t2, $t2
	andi $t2, 0x00000001
	j sqrlp
sqrend: 
	# convert our guess to an int
	cvt.w.d $f4, $f4
	mfc1.d $t0, $f4 # t0, t1 = f4, f5
	add $s0, $0, $t0
	add $s0, $0, $t1
	# if round-up is needed, add it here
	add $t0, $t0, $t2
	jr $ra
	
printstr: # store string pointer into a0
	li $v0, 4
	syscall 
	jr $ra
	
readint: # will return int in v0
	li $v0, 5
	syscall
	jr $ra
	
printint:
	li $v0, 1
	syscall 
	jr $ra
	
readdouble: # will return double in f0
	li $v0, 7
	syscall
	jr $ra
	
printdouble: # will print value in f12
	li $v0, 3
	syscall
	jr $ra
	
exit:
	li $v0, 10
	syscall
