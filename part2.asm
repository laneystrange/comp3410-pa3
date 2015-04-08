# Hien Vo
# COMP3410
# Spring 2015
# Programming Assignment #3 (PA3)
# Assigned: 4/1/15
# Deadline: 4/8/15

.data
number: .asciiz "Please enter a float number\n"
exponent: .asciiz "Please enter an integer exponent:\n"
result: .asciiz "result:\n"
float: .float 1.0

.text
	li $v0, 4
	la $a0, number	#print string number
	syscall

	li $v0, 6 	#input a float number
	syscall

	li $v0, 4
	la $a0, exponent 	#print string power
	syscall

	li $v0, 5 	#input an integer
	syscall
	
	mov.s $f12, $f0
	move $a0, $v0
	jal power
	
	mov.s $f12,$f0 #move $f0 to $f12
	
	la $a0, result
	li $v0,4
	syscall
	li $v0, 2
	syscall
	
	li $v0, 10
	syscall
	
power:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	l.s $f0, float
	beqz $a0, zero_return
	bgtz $a0, positive_return
	bltz $a0, negative_return
	
zero_return:
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra
positive_return:
	subi $a0,$a0,1
	jal power
	mul.s $f0,$f12,$f0
	b zero_return
negative_return:
	addi $a0,$a0,1
	jal power
	div.s $f0,$f0,$f12
	b zero_return
	 
	 
	
		




