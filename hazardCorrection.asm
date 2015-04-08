#####################################################
# BELOW IS THE ORIGINAL CODE AS COPIED OUT OF THE PROJECT DESCRIPTION FILE:
# IT HAS BEEN COMMENTED TO EXPLAIN THE ACTIONS OF EACH STEP THAT IS SHOWN.

# lw  $s2, 0($s1) --> load value in $s1 offset 0, into $s2
# lw  $s1, 16($s6) --> load value in $s6 offset 16, into $s1
# sub $s6, $s1, $s2 --> $s6 = $s1 - $s2
# add $s6, $s2, $s2 --> $s6 = $s2 + $s2
# or  $s3, $s6, $zero --> bitwise or $s6 with zero (keeps $s6 the same), stores in $s3
# sw  $s6, 12($s1) --> store value in $s1 offset 12, into $s6
# addi $s4, $s4, 10 --> $s4 = $s4 + 10
# subi $s5, $s4, 4 --> $s5 = $s4 - 4
#####################################################
.data
array1: .word 3,4,5,6
array2: .word 6,5,4,3

.text
la $s1,array1
la $s6,array2

lw $s2, 0($s1)		# load value in $s1 offset 0, into $s2 ($s1 not affected)
lw $s1, 16($s6)		# load value in $s6 offset 16, into $s1 ($s6 not affected)
add $s6, $s2, $s2	# $s6 = $s2 + $s2lw  $s2, 0($s1)	
addi $s4, $s4, 10	# $s4 = $s4 + 10
or  $s3, $s6, $zero	# place copy of $s6 into $s3
#sw  $s6, 12($s1)	# store $s6 into $s1 offset 12
sub $s6, $s1, $s2	# $s6 = $s1 - $s2
subi $s5, $s4, 4	# $s5 = $s4 - 4

# EXIT PROGRAM CLEANLY
	      li   $v0, 10      # prep call for program exit
	      syscall           #continue with exiting