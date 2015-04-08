# COMP3410 Hazard Circumvention (Part 1)
# Author: Kieran Blazier
# Assignment: PA[3]
# Date: 4/8/15

# part2.asm
	
	.include "macros.asm"

	.data
	
array1: .word 1, 2, 3, 4
array2: .word 1, 2, 3, 4, array1

	.text
	
main:
	la $s1, array1		# *set up the arrays
	la $s6, array2		# *
	nop			# *pad out to a multiple of 5 (pretend important things happened here)
	nop			# *
	nop			# *
	
	lw  $s2, 0($s1)		      #| if | id | ex | mem | wb
	lw  $s1, 16($s6)	      	   #| if | id | ex  | mem | wb
	addi $s4, $s4, 10		        #| if | id  | ex  | mem | wb <-- Inserting this prevents a hazard between the lw above and the sub below
	sub $s6, $s1, $s2	                     #| if  | id  | ex  | mem | wb
	add $s6, $s2, $s2	     		           #| if  | id  | ex  | mem | wb <-- Due to the insertion, the pipeline flushes here
	or  $s3, $s6, $zero	      #| if  | id  | ex  | mem | wb <-- Because the pipeline flushed, there is no hazard between this or and the add above
	sw  $s6, 12($s1)                    #| if  | id  | ex  | mem | wb
	subi $s5, $s4, 4	    	          #| if  | id  | ex  | mem | wb
	
	# Other than what was mentioned, there were no other hazards, so all hazards have been avoided.
	# The program saves a 2 into array1 at the position where a 4 was previously
	
	exit			# exit the program