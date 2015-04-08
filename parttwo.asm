# Claire Skaggs
# COMP 3410
# Programming Assignment 3
# Part Two

.data
srtpmpt:	.asciiz "This program calculates x^k, where x is a floating point and k is an integer. \n"
xvlpmpt:	.asciiz "Enter x (floating point value): "
kvlpmpt:	.asciiz "Enter k (integer value): "
rstpmpt:	.asciiz "x^k = "

.text
main:
li $v0, 4		# load syscall code for print string into the return value register
la $a0, srtpmpt		# load the string 'srtpmpt' address into the argument register
syscall			# make the syscall to print the 'srtpmpt' string

li $v0, 4		# load syscall code for print string into the return value register
la $a0, xvlpmpt		# load the string 'xvlpmpt' address into the argument register
syscall			# make the syscall to print the 'xvlpmpt' string

li $v0, 6		# load syscall code for read float into the return value register
syscall			# make the syscall to read the float from the user; stored in $f0
mov.s $f6, $f0		# move the float into from $f0 into $f6; this copy is used later

li $v0, 4		# load syscall code for print string into the return value register
la $a0, kvlpmpt		# load the string 'kvlpmpt' address into the argument register
syscall			# make the syscall to print the 'kvlpmpt' string

li $v0, 5		# load syscall code for read int into the return value register
syscall			# make the syscall to read the int from the user; stored in $v0
move $s0, $v0		# move the int value from $v0 into $s0; this is the int exponent

loop:
beq $s0, 1, result	# if $s0 = 1, then jump to the 'result' label, else continue
mul.s $f0, $f0, $f6	# $f0 = $f0 * $f6, this performs the exponential calculation
subi $s0, $s0, 1	# $s0 = $s0 - 1, this decrements the int exponent each loop
j loop			# unconditionally jump to the 'loop' label

result:
li $v0, 4		# load syscall code for print string into the return value register
la $a0, rstpmpt		# load the string 'rstpmpt' address into the argument register
syscall			# make the syscall to print the 'rstpmpt' string

li $v0, 2		# load syscall code for print float into the return value register
add.s $f12, $f0, $f4	# load the float result value into the argument register
syscall			# make the syscall to print the float result value

exit:
li $v0, 10		# load syscall code for exit program
syscall			# make the syscall to exit the program