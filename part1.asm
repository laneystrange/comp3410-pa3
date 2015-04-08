#Ben Murphy
#COMP 3410 PA3
#Part 1 - Avoiding Hazards

.text
#memory block looks like this to start:  $sp, -4($sp) = 12($s1), -8($sp) = 16($s6)
addi $s6, $sp, -24	#memory address for $s6, weird number because of the 16 offset
addi $s1, $sp, -16	#memory address for $s1
or $t0, $sp, $zero		#to make MIPS work nicely later
ori $t1, 4
sw $t0, 16($s6)	#give 0($s6) some value
sw $t1, 12($s1)	#give 12($s1) some value
sw $t1, 0($s1)	#give 0($s1) some value
nop				#pipeline padding so it flushes for the actual code
nop
nop

#the main part of the program
lw $s2, 0($s1)		#no problems with these two
lw $s1, 16($s6)
addi $s4, $s4, 10		#moved this up so below's EX matches with above's WB
sub $s6, $s1, $s2
add $s6, $s2, $s2	#all clear - pipeline flushes at this point
or $s2, $s6, $zero
sw $s6, 12($s1)
subi $s5, $s4, 4		#don't even need to do anything with this

li $v0, 10	#exit gracefully
syscall
