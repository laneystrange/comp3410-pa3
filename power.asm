# power.asm ~ calculates n^k where n is a floating point number, and k is an integer

.data
	s_introduction: .asciiz "Hello, welcome to power.asm, by Kevin Fisher!\n"
	s_inputn: .asciiz "Please input a number to raise to some power: \n"
	s_inputk: .asciiz "Please input a power to raise it to: \n"
	s_result: .asciiz "The result is: \n"
	fp_one: .float 1
	
.text
start:
	la $a0, s_introduction
	jal printstr # print welcome text
	la $a0, s_inputn
	jal printstr # prompt for a float value
	jal readfloat # $f0 now holds that value
	la $a0, s_inputk
	jal printstr # prompt for a int value
	jal readint #v0 now holds that value
	add $a0, $0, $v0 # move it to s0
	
	#calculate
	jal raisepwr
	
	# move result to f12
	mov.d $f12, $f0
	
	# print result string
	la $a0, s_result
	jal printstr
	# print answer
	jal printfloat
	
	j exit

raisepwr: #raises number in f0 to number in a0
	# now, if the number to raise by is negative,
	# we divide 1 by the input number
	addi $t0, $0, 0
	bgt $a0, $t0, strtlp
	l.s $f2, fp_one
	div.s $f0, $f2, $f0
	abs $a0, $a0
strtlp:mov.d $f2, $f0
	# first, if a0 is 1, then we are done
pwrlp:	addi $t0, $0, 1 # t0 = 1
	beq $a0, $t0, endpwr
	mul.s $f0, $f2, $f0
	addi $a0, $a0, -1 # decrement a0
	j pwrlp # loop back
endpwr:	jr $ra

printstr: # store string pointer into a0
	li $v0, 4
	syscall 
	jr $ra
	
readint: # will return int in v0
	li $v0, 5
	syscall
	jr $ra
	
readfloat: # will return float in f0
	li $v0, 6
	syscall
	jr $ra
	
printfloat: # will print value in f12
	li $v0, 2
	syscall
	jr $ra

exit:
	li $v0, 10
	syscall
