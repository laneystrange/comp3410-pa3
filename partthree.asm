# Claire Skaggs
# COMP 3410
# Programming Assignment 3
# Part Three

.data
srtpmpt:	.asciiz "This program approximates the nearest integer square root of a floating point number. \n"
valpmpt:	.asciiz "Enter your floating point number: "
rstpmpt:	.asciiz "The approximate result is: "

.text
main:
li $v0, 4		# load syscall code for print string into the return value register
la $a0, srtpmpt		# load the string 'srtpmpt' address into the argument register
syscall			# make the syscall to print the 'srtpmpt' string

li $v0, 4		# load syscall code for print string into the return value register
la $a0, valpmpt		# load the string 'valpmpt' address into the argument register
syscall			# make the syscall to print the 'valpmpt' string

li $v0, 7		# load syscall code for read double into the return value register
syscall			# make the syscall to read the double from the user; stored in $f0

loop:
mul $t1, $t0, $t0	# $t1 = $t0 * $t0; this repeatedly squares every loop pass
mtc1 $t1, $f2		# $f2 = $t1; this copy is used to compare the value with the float
cvt.d.w $f2, $f2	# convert the value in $f2 to double precision
c.eq.d 0, $f2, $f0	# if $f2 = $f0, then condition flag 0 is set to true, else it is set to false
c.lt.d 1, $f2, $f0	# if $f2 < $f0, then condition flag 1 is set to true, else it is set to false
bc1t 0, sqrtdone	# if the condition flag 0 is true, then jump to the label 'sqrtdone'
bc1f 1, sqrtappx	# if the condition flag 1 is true, then jump to the label 'sqrtappx'	
addi $t0, $t0, 1	# $t0 = $t0 + 1; increments the test int to be squared every loop pass
j loop			# unconditionally jump to the 'loop' label

sqrtappx:
subi $t0, $t0, 1	# $t0 = $t0 - 1; if we reached here then we are approximating the root

sqrtdone:	
li $v0, 4		# load syscall code for print string into the return value register
la $a0, rstpmpt		# load the string 'rstpmpt' address into the argument register
syscall			# make the syscall to print the 'rstpmpt' string

li $v0, 1		# load syscall code for print int into the return value register
move $a0, $t0		# load the int result value into the argument register
syscall			# make the syscall to print the int result value

exit:
li $v0, 10		# load syscall code for exit program
syscall			# make the syscall to exit the program