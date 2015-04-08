.data
linebreaker: .asciiz "\n"
askfloat: .asciiz "Enter a float.\n"
askint: .asciiz "Enter an exponent.\n"
answer: .asciiz "Answer is:\n"
fp1: .float 1.0

.text
li $v0, 4
la $a0, askfloat ##Ask user for a float (single-precision)
syscall


li $v0, 6 #user enters float
syscall


li $v0, 4
la $a0, askint #ask user for an exponent.
syscall


li $v0, 5 #user enters exponent.
syscall

move $s0, $v0 #store exponent in s0
bltz $s0, NegExp    #if negative, jump.
j EXP

NegExp: #absolute value the negative number and raise a flag.
abs $s0, $s0
li $t1, 1
j EXP

HandleNeg: #divide 1 by the positive version of the exponentation.
l.s $f2, fp1
div.s $f0, $f2, $f0 #store in f0
li $t1, 0 #remove the flag, and jump
j CONT

ZERO:
l.s $f0, fp1
j CONT


EXP:
    mov.s $f1, $f0
Loop:    
    beq $s0, 1, CONT #if exponent is 1, continue.
    #otherwise, multiply float by itself, deduct one from the exponent, and continue.
    beqz $s0, ZERO
    mul.s $f0, $f0, $f1
    addi $s0, $s0, -1
    j Loop
    
CONT:
beq $t1, 1, HandleNeg
#if a flag is raised, jump.
#when returned back to CONT, will have the correct value.


li $v0, 4
la $a0, linebreaker
syscall

la $a0, answer #tell user the following is the answer
syscall

mov.s $f12, $f0 #move float into register to print
li $v0, 2
syscall

li $v0, 10 #end program
syscall
