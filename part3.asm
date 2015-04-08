# Omer Aldafari
# 4/8/15
# PA3


.data
float : .asciiz "Enter a positive floating number that will have square root taken\n"
error : .asciiz "n\Number was not positive; please try again"
newline: .asciiz "\n"
floatzero: .double 0.0
floatone: .double 1.0
floatp1: .double 0.1
floatp5: .double 0.5
# main
.text
	la $s0, floatzero
	l.d $f30, ($s0) # result here
	la $s1, floatone
	l.d $f2, ($s1) # incremented
	la $s2, floatp1
	l.d $f28, ($s2)
	
	la $a0,float # printing the message
	li $v0,4
	syscall
	 
checkinput:	
	li $v0, 7 # double floating point input from user
	syscall
	
	
	la $a0,newline # new space
	li $v0,4
	syscall
	
	c.le.d $f0,$f30 # if number is not greater than 0 then reenter positive number
	bc1t error
	
	j continue
errormessage:
		la $a0,error # printing message
		li $v0,4
		syscall
		j checkinput

continue:
	
	c.eq.d $f0, $f4
	bc1t done
	c.lt.d $f4,$f0
	bc1t increment
	
	mul.d $f6,$f30,$f30
	c.lt.d $f0,$f6
	bc1t decrement
	j continue2
	#otherwise we need to get approximation and round
	
	
increment:
	add.d $f30,$f30, $f2
	mul.d $f4,$f30,$f30
	j continue
	
decrement:
	sub.d $f30, $f30,$f2
	mov.d $f24, $f30
	
	addi $t2, $0, 0 #i=0
	addi $t3, $0,9 #continue2 limit of looping i<5
continue2:
	addi $t2,$t2,1
	bgt $t2,$t3, check
	add.d $f30, $f30, $f28
	mul.d $f26, $f30, $f30
	c.lt.d $f26,$f0
	bc1t continue2
	
	sub.d $f30, $f30,$f28
	
check:

	la $s1, floatp5
	l.d $f2, ($s1)
	la $s2, floatone
	l.d $f28, ($s2)
	
	add.d $f30, $f30, $f2 #result = result+ 0.5
	add.d $f24, $f24, $f28 # c+1
	
	c.le.d $f24,$f30
	bc1f printc
	mov.d $f30,$f24	
	j done
	
printc:
	sub.d $f24, $f24, $f28
	mov.d $f30, $f24

done:
	cvt.w.d $f30, $f30
	mfc1.d $t0, $f30
	
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall



