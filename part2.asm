.data

one: .float 1.0 #value in memory
lineBr: .asciiz "\n" #strings
lineB: .asciiz "\nFirst Value = " #string 
lineC: .asciiz "\nSecond Value = " #string

.text 

li $v0, 6 #read a float
syscall
#f0 contains the float
mov.s $f1, $f0 #move value to f1

li $v0, 4 #prepare to print string
la $a0, lineB
syscall 

li $v0, 2 #prepare to print float
mov.s $f12, $f0
syscall

li $v0, 4 #prepare to print string 
la $a0, lineBr
syscall 


li $v0, 5 #read an integer
syscall

move $t1, $v0 #move the int to t1
move $t2, $v0 #move the int to t2


li $v0, 4 #prepare to print a string
la $a0, lineC
syscall

li $v0, 1 #prepare to print an int
move $a0, $t1
syscall

li $v0, 4 #prepare to print a string
la $a0, lineBr
syscall


li $t0, -1 #negative counter
bltz $t1, NegLoop #if exponent is negatvie then branch
li $t0, 1 #positive counter




subroutine: #subroutine
PosLoop: #loop 1 handles positives
	beq $t0, $t1, EndLoop #end if finished
	mul.s $f0, $f0, $f1 #multiply the value by itself
	addi $t0, $t0, 1 #counter
	j PosLoop #jump back to beginning of loop
	
	
NegLoop: #loop 2 handles negative numbers
	beq $t0, $t1, FinLoop #end if finished
	mul.s $f0, $f0, $f1 #multiply the value by itself
	subi $t0, $t0, 1 #counter
	j NegLoop #jump back to neg loop 
FinLoop:#not a loop, just the next step for the ending of the loops

	l.s $f1, one #load single precision value from memory into f1
	div.s $f0, $f1, $f0	#diviide single precision value by 1
EndLoop:
	li $v0, 2 #prepare to print a float
	mov.s $f12, $f0 #move value to be printed to f12
	syscall
	
	li $v0, 10 #prepare to close  
	syscall #end program
	
