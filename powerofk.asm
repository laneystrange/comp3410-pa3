.data
in: .asciiz "Please enter a number: \n"
inex: .asciiz "Please enter a exp: \n"
anstext: .asciiz "The answer is: \n"
basic: .float 1.0

.text

start: 
	la $a0, in #loads starting text
	jal prstr
	jal rsingle
	la $a0, inex #loads exp text
	jal prstr
	jal rint
	add $s0, $zero, $v0 #puts $v0 into s0
	l.s $f12, basic #set f12 to 1
	beqz $s0, setone #flag for 0
	blt $s0, $zero, setneg #flag for negative numbers
	j setpos
setone:
	la $a0, anstext #just prints text and 1.0
	jal prstr
	jal prsing
	j exit
	
setneg:
	sub $t0, $zero, $s0 #set to positive counter
	l.s $f2, basic #for division
loopn:	mul.s $f12, $f12, $f0 #does the mult
	addi $t0, $t0, -1 #counter --
	bnez $t0, loopn # loop if not 0
	div.s $f12, $f2, $f12 # divides 1/ ans
	la $a0, anstext #prints f12
	jal prstr
	jal prsing
	j exit
	
setpos:
	add $t0, $zero, $s0 # set pos counter
loop:	mul.s $f12, $f12, $f0 # does mult
	addi $t0, $t0, -1 #counter--
	bnez $t0, loop #loops if not zero
	la $a0, anstext #prints
	jal prstr
	jal prsing
	j exit
	
print:
	li $v0, 1
	syscall 
	jr $ra
prsing:
	li $v0, 2
	syscall 
	jr $ra
rsingle:
	li $v0, 6
	syscall
	jr $ra
rint:
	li $v0, 5
	syscall
	jr $ra
prstr:
	li $v0, 4
	syscall
	jr $ra

exit:
	li $v0, 10
	syscall