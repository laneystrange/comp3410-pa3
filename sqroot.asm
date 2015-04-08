.data
inptext: .asciiz "Please enter a positive number: \n"
outtext: .asciiz "Square root: \n"
errortext: .asciiz "The number you enter can't be less than 0!"
inc: .double 1.0
st: .double 0.0

.text

begin:
	la $a0, inptext #loads starting text
	jal prstr
	jal rdouble
	l.d $f2, st  #load start d into f2
	l.d $f4, inc #load inc into $f4
	
	c.lt.d $f0, $f2 #check for negative numbers
	bc1t error
loop:
	mul.d $f8, $f2, $f2 # f2 squared
	c.lt.d $f0, $f8 #check that is still less than squared number
	bc1t convert
	add.d $f2, $f2, $f4 #inc
	j loop
convert:
	sub.d $f2, $f2, $f4 #sub to get real square root
	cvt.w.d $f2, $f2 #convert to word
	mfc1.d $t0, $f2 #move from coproc
	la $a0, outtext #load out text
	jal prstr
	add $a0, $t0, $zero # get ready to print int
	jal print	
	j exit
error: 
	la $a0, errortext
	jal prstr
	j exit
rdouble:
	li $v0, 7
	syscall
	jr $ra
print:
	li $v0, 1
	syscall 
	jr $ra
prstr:
	li $v0, 4
	syscall
	jr $ra

exit:
	li $v0, 10
	syscall