.data
xvalue:	.asciiz	   "Enter the number: \n"
exponent:		.asciiz	   "Enter the exponent: \n"
msg		: .asciiz "The values cannot be zero. Program will end now."
Answer: .asciiz "The answer is: "
Ended: .asciiz "\n--Ended--"

.text
.globl	main
main:

	li	$v0, 4			# printing message for xvalue
	la	$a0, xvalue		
	syscall			
	li	$v0, 6			
	syscall			
	mov.s $f5, $f0		#$f9 have xvalue
	mov.s $f9, $f5		##### convert float to int
	cvt.w.s $f9, $f9
	mfc1 $t1, $f9
	beq $t1,0,ErrorGenerated
	
	li	$v0, 4			# printing message for exponent
	la	$a0, exponent		
	syscall	
	li	$v0, 6			# read in the amount tendered
	syscall	
	mov.s $f7, $f0		
	cvt.w.s $f7, $f7
	mfc1 $t0, $f7
	
	beq $t0,0,PrintIfExponentZero
	blt $t0,0,Loop_NegetiveExponent
	j Loop_PositiveExponent
	
	Loop_NegetiveExponent:
	li $t3,0
	li.s $f1,1.0
	mul $t0,$t0,-1
	Loop_N:
	beq $t3,$t0,Temp
	mul.s $f1,$f1,$f5
	add $t3,$t3,1
	j Loop_N
	
	
	Temp:
	li.s $f3,1.0
	div.s $f12,$f3,$f1
	mov.s $f5,$f12
	bgt $t1,0,CheckEvenExponent
	li $t5,2
	div $t0, $t5
	mfhi $t6
	beq $t6,0,PrintPositive
	j PrintNegetive
	CheckEvenExponent:
	li $t5,2
	div $t0, $t5
	mfhi $t6
	beq $t6,0,PrintPositive
	
	
	PrintNegetive:
	li.s $f2,-1.0
	mul.s $f5,$f5,$f2
	li	$v0, 4		
	la	$a0, Answer		
	syscall
	li $v0, 2
	syscall
	j EndProgram
	
	
	PrintPositive:
	li	$v0, 4		
	la	$a0, Answer		
	syscall
	li $v0, 2
	syscall
	j EndProgram
	
	Loop_PositiveExponent:
	li $t3,1
	li.s $f1,1.0
	Loop_P:
	bgt $t3,$t0,Here
	mul.s $f1,$f1,$f5
	add $t3,$t3,1
	j Loop_P
	
	
	Here:
	bgt $t1,0,PrintP
	li $t5,2
	div $t0, $t5
	mfhi $t6
	beq $t6,0,PrintAnsP
	PrintN:
	li.s $f2,-1.0
	mul.s $f1,$f1,$f2
	li	$v0, 4		
	la	$a0, Answer		
	syscall	
	li $v0, 2
	mov.s $f12, $f1
	syscall
	j EndProgram
	
	PrintP:
	li $t5,2
	div $t0, $t5
	mfhi $t6
	beq $t6,0,PrintAnsP
	
	PrintAnsP:
	li	$v0, 4		
	la	$a0, Answer		
	syscall	
	li $v0, 2
	mov.s $f12, $f1
	syscall
	j EndProgram
	
	
	ErrorGenerated:
	li	$v0, 4		
	la	$a0, msg		
	syscall			
	j EndProgram
	
	PrintIfExponentZero:
	li	$v0, 4		
	la	$a0, Answer		
	syscall	
	li $t7,1
	move $a0,$t7
	li $v0,1
	syscall
	j EndProgram
	
	EndProgram:
	li	$v0, 4			# printing message for xvalue
	la	$a0, Ended		
	syscall		
	
	li $v0,10
	syscall
