# Author: Tam Duong
# Assignment: PA3#1
# Date: 4/8/15

	.data 
	
A1:	.word 1, 2, 3, 4
A2:	.word 1, 2, 3, 4, 5

	.text
	
la $s1, A1
la $s6, A2
lw  $s2, 0($s1)
lw  $s1, 16($s6)
addi $s4, $s4, 10		# avoid hazard by sticking addi instruction between the 2 instructions. In this case addi instruction 
				# does not use any of the same register then it consider as other instruction so it is safe to put it in between the 2 instructions.
sub $s6, $s1, $s2
add $s6, $s2, $s2
subi $s5, $s4, 4		# same for this hazard, subi does not use anyof the same register so use this instruction to avoid the hazard.
or  $s3, $s6, $zero
sw  $s6, 12($s1)

### Exit ###
li $v0, 10
syscall	