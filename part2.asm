#Ben Murphy
#COMP 3410 PA3
#Part 2

.data
prompt1: .asciiz  "Floating-point base?: "
prompt2: .asciiz "Integer power?: "
result:  .asciiz "Result is "

.text
la $a0, prompt1	#prepare float prompt
jal printstr
li $v0, 6	#prepare to read float
syscall	#read it, fp is now in $f0
la $a0, prompt2	#prepare int prompt
jal printstr
li $v0, 5	#prepare to read int
syscall	#read it, int is now in v0
move $a0, $v0	#prepare argument for power subroutine
lui $t0, 16256	#when loaded into FPU, this is 2^0, or 1
mtc1 $t0, $f2		#load 1 into FPU, so we can have something not-zero to multiply by
bgezal $a0, pospow	#we have to check greater than zero because $a0 = 0 at the end of both
bltzal $a0, negpow	#use negative power if necessary
la $a0, result		#more flavor text
jal printstr
li $v0, 2		#print float
mov.s $f12, $f2	#$f12 is the float to be printed
syscall
j exit

printstr:
	li $v0, 4	#prepare to print string
	syscall	#print it
	jr $ra
	
pospow:
	addi $sp, $sp, -4	#power is recursive...
	sw $ra, 0($sp)	#...so we have to store the RA
	addi $a0, $a0, -1	#counter is unconditionally decremented every recursive iteration (before the branch)
	beq $a0, $zero, poszero	#poszero just lets us stop recursing
	jal pospow	#call pow(x, y-1)
poszero:			#base case of 0 just means we can finally begin working back up, but all instances of pow need to do these instructions
	mul.s $f2, $f2, $f0	#f2 is 1 at first, so you have 1*x. the next iteration is x*x, etc
	lw $ra, 0($sp)	#return to previous instance of pow
	addi $sp, $sp, 4
	jr $ra

negpow:
	addi $sp, $sp, -4	#power is recursive...
	sw $ra, 0($sp)	#...so we have to store the RA
	addi $a0, $a0, 1	#counter is unconditionally incremented every recursive iteration (before the branch)
	beq $a0, $zero, negzero	#base case is x^y, y = 0
	jal negpow	#call pow(x, y-1)
negzero:			#base case of 0 just means we can finally begin working back up, but all instances of pow need to do these instructions
	div.s $f2, $f2, $f0	#f2 is 1 at first, so you have 1/x. the next iteration is (1/x)/x = (1/x) * (1/x)
	lw $ra, 0($sp)	#return to previous instance of pow
	addi $sp, $sp, 4
	jr $ra

exit:
	li $v0, 10	#argument for exit program
	syscall		#exit it
