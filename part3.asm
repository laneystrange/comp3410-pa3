#Ben Murphy
#COMP 3410 PA3
#Part 3 - Floating Square Roots, Rounded

.data
prompt: .asciiz "Enter a decimal to get square-rooted: "
complete: .asciiz "The square root rounded to the nearest whole number is: "
badinput: .asciiz "Asking me to calculate imaginary square roots? Nah."
pointfive: .double 0.5

.text
la $a0, prompt
jal printstr
li $v0, 7
syscall
c.lt.d $f0, $f2
bc1t negative
mov.d $f12, $f0	#copy it both as an outgoing argument
mov.d $f14, $f0	#and to a safe spot (second arg for newton's method later
jal float_sqrt
mov.d $f12, $f0	#copy the floating result as an outgoing argument for rounding
jal round_int
move $t0, $v0	#save the rounded int
la $a0, complete
jal printstr
move $a0, $t0
jal pr_int
j exit

float_sqrt:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal round_int		#get integer round for an approximate square root calc
	move $a0, $v0	#result will get roughly sqrted
	jal int_sqrt
	mtc1 $v0, $f16	#load int sqrt as first guess for newton's method
	cvt.d.w $f12, $f16	#convert it from word to double, as first arg to newton (original is already in second arg at $f14)
	jal newton		#do newton's method
	lw $ra, 0($sp)
	addi $sp, $sp, 4
jr $ra

round_int:
	addi $sp, $sp,  -4
	sw $ra, 0($sp)
	l.d $f0, pointfive		#prepare to add 0.5
	add.d $f16, $f12, $f0	#added
	cvt.w.d $f16, $f16		#convert to int - this truncates, which will round correctly now
	mfc1.d $v0, $f16		#return to registers
	lw $ra, 0($sp)
	addi $sp, $sp, 4
jr $ra

#shoutout to wikipedia for showing me the digit-by-digit square root that's easy on the division	
int_sqrt:
	move $t0, $a0			#put argument in a safer place
	li $t1, 0					#result = 0
	li $t2, 1			
	sll $t2, $t2, 30			#1 << (size of word - 2). Thiskeeps track of what bit we're looking at
	while1:					#we want the largest power of four smaller than the input
		ble $t2, $t0, while2
		srl $t2, $t2, 2			#srl 2 = divide by four
		j while1
	while2:					#the main meat
		beqz $t2, isqrt_finish
		add $t3, $t1, $t2		#for comparison
		bge $t0, $t3, isqrt_if	#if the input is greater than the current result + the set bit
		srl $t1, $t1, 1			#if it's not, divide the result by 2
		j postif
		isqrt_if:
			sub $t0, $t0, $t3	#input -= current result + set bit
			srl $t1, $t1, 1		#divide the result by 2
			add $t1, $t1, $t2	#and add the set bit to it
		postif:
			srl $t2, $t2, 2		#always divide by four
			j while2
	isqrt_finish:
		move $v0, $t1		#set return value
jr $ra						#return
		
newton:
	li $t1, 0
	li $t0, 1				#here we set up A = 1/a, which is used in every iteration
	mtc1 $t0, $f1		#move 1 to coproc 1
	cvt.d.w $f2, $f1		#convert it to a float
	div.d $f2, $f2, $f14	#$f2 = 1/arg
	li $t0, 3				#3 is also a constant we will need, shown below
	mtc1 $t0, $f1
	cvt.d.w $f4, $f1		#f4 = 3
	li $t0, 2
	mtc1 $t0, $f1
	cvt.d.w $f6, $f1		#$f6 = 2
	li $t0, 6				#six iterations of newton gives a ton of precision
	newton_loop:		#The equation is: x' = x(3 - A * x^2)/2
		beqz $t0, newton_finish
		mul.d $f14, $f12, $f12	#x^2
		mul.d $f14, $f14, $f2	#A*x^2
		sub.d $f14, $f4, $f14	#3 - (A*x^2)
		mul.d $f14, $f14, $f12	#x(3-A*x^2)
		div.d $f12, $f14, $f6	#x' = x(3-A*x^2)/2
		addi $t0, $t0, -1	#decrement counter
		j newton_loop
	newton_finish:
		mov.d $f0, $f12
jr $ra

negative:
	la $a0, badinput
	jal printstr
j exit
		
pr_int:
	li $v0, 1
	syscall
jr $ra
	
printstr:
	li $v0, 4
	syscall
jr $ra
	
exit:
	li $v0, 10
syscall