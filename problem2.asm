.data
xvalue:	.asciiz	   "Enter the number: \n"
exponent:		.asciiz	   "Enter the exponent: \n"
msg		: .asciiz "The values cannot be zero. Program will end now."
Answer: .asciiz "The answer is: "
Ended: .asciiz "\n--Ended--"
fp1: .float 1.0
fp2: .float -1.0


.text
.globl	main
main:
	
	li	$v0, 4			# printing message for xvalue
	la	$a0, xvalue		
	syscall			
	li	$v0, 6			
	syscall			
	mov.s $f5, $f0		#$f5 have xvalue
	mov.s $f9, $f5		##### convert float to int
	cvt.w.s $f9, $f9
	mfc1 $t1, $f9
	
	beq $t1,0,ErrorGenerated
	
	l.s $f2, fp2
	l.s $f9, fp1
	l.s $f3, fp1
	
	li	$v0, 4			# printing message for exponent
	la	$a0, exponent		
	syscall	
	li	$v0, 6			# read in the amount tendered
	syscall	
	mov.s $f7, $f0		
	cvt.w.s $f7, $f7
	mfc1 $t0, $f7
	
	beq $t0,0,PrintIfExponentZero
	bgt $t0,0,Positive
	
	mul $t0,$t0,-1
	li $t3,0
	Loop_N:
	beq $t3,$t0,Temp
	mul.s $f3,$f3,$f5
	add $t3,$t3,1
	j Loop_N
	Temp:
	div.s $f12,$f9,$f3
	mov.s $f3,$f12
	jal CheckIfNumberIsPositive
	jal CheckIfExponentIsEven
	beq $t7,1,PrintAnswerP
	beq $t8,1,PrintAnswerP
	j PrintAnswerN
	
	
	
	Positive:
	li $t3,0	#set counter to 0
	Loop_P:
	beq $t3,$t0,Here 
	mul.s $f3,$f3,$f5
	add $t3,$t3,1
	j Loop_P
	Here:
	jal CheckIfNumberIsPositive
	jal CheckIfExponentIsEven
	beq $t7,1,PrintAnswerP
	beq $t8,1,PrintAnswerP
	j PrintAnswerN
	
	
	CheckIfNumberIsPositive:
	bgt $t1,0,PMessage
	li $t7,0
	jr $ra
	PMessage:
	li $t7,1
	jr $ra
	
	CheckIfExponentIsEven:
	li $t5,2	#load 2 into t5 to check if even
	div $t0, $t5	#divide by two
	mfhi $t6
	beq $t6,0,EvenExponent #if it is equal to zero then it is even
	li $t8,0		#load zero into t8
	jr $ra
	EvenExponent:
	li $t8,1	#if exponent is even then load 1 into t8
	jr $ra
	
	PrintAnswerP:	#printing p 
	mov.s $f12,$f3
	li	$v0, 4		
	la	$a0, Answer		
	syscall
	li $v0, 2
	syscall
	j EndProgram
	
	PrintAnswerN: 	#printing n
	mul.s $f3,$f3,$f2
	mov.s $f12,$f3
	li	$v0, 4		
	la	$a0, Answer		
	syscall
	li $v0, 2
	syscall
	j EndProgram
	
	
	
	PrintIfExponentZero:
	li	$v0, 4		#if positive set up print
	la	$a0, Answer	#print the answer
	syscall			#call syscall
	li $t7,1
	move $a0,$t7
	li $v0,1		#set up to print int
	syscall			#print int
	j EndProgram		#end program
	
	ErrorGenerated:	
	li	$v0, 4		#load print string	
	la	$a0, msg	#print error message
	syscall			#call syscall
	j EndProgram		#end program
	
	EndProgram:
	li	$v0, 4			# printing message for xvalue
	la	$a0, Ended		
	syscall		
	
	
	#end the program
	li $v0,10			#load the call to end the program
	syscall				#call syscall
	
