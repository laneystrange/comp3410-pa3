# Claire Skaggs
# COMP 3410
# Programming Assignment 3
# Part One

.data
frstarray: .word 1, 2, 3, 4
secdarray: .word 1, 2, 3, 4, frstarray

.text
main:
la $s1, frstarray	# load the array 'frstarray' address into the $s1 register
la $s6, secdarray	# load the array 'secdarray' address into the $s6 register

hazards:
lw $s2, 0($s1)
addi $s4, $s4, 10	# change 1; see README
lw $s1, 16($s6)
sub $s6, $s1, $s2
subi $s5, $s4, 4	# change 2; see README
add $s6, $s2, $s2
sw $s6, 12($s1)		# change 3; see README
or $s3, $s6, $zero

exit:
li $v0, 10		# load syscall code for exit program
syscall			# make the syscall to exit the program