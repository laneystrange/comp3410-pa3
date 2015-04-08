# COMP3410 Power Function (Part 2)
# Author: Kieran Blazier
# Assignment: PA[3]
# Date: 4/8/15

# part2.asm
# Input: A float base, an integer exponent
# Output: The resulting power
	
	.include "macros.asm"

	.data
	
prompt_base: .asciiz "Input a floating point base: "
prompt_exp: .asciiz "Input an integer exponent: "
result: .asciiz "Result: "
one: .float 1.0

	.text
	
main:
	la $a0, prompt_base	# write the first prompt 
	print_str
	
	read_float		# read the base into $f0
	
	la $a0, prompt_exp	# write the second prompt 
	print_str
	
	read_int		# read the exponent into $v0
	
	mov.s $f12, $f0		# pass $f0 as $f12
	move $a0, $v0		# pass $v0 as $a0
	
	jal pow			# $f0 = pow($f12, $a0)
	
	la $a0, result		# write the result message
	print_str
	
	mov.s $f12, $f0		# pass the result
	print_float		# print the result

	exit			# exit the program

##########################################################
# function: pow
# takes --
# $f12 : base
# $a0 : exponent
# returns --
# $f0 : power
##########################################################
pow:
	addi $sp, $sp, -4		# reserve one word on the stack
	sw $ra, 0($sp)			# save the $ra
	
	l.s $f0, one
	beqz $a0, pow.return		# n == 0, return 1.0
	bgtz $a0, pow.recurse.pos	# n > 0, recurse positive case
	bltz $a0, pow.recurse.neg	# n < 0, recurse negative case
pow.recurse.pos:	
	sub $a0, $a0, 1 
	jal pow 			# call pow(x, k - 1)
	
	mul.s $f0, $f12, $f0 		# $f0 = x * pow(x, k - 1)
	b pow.return			# return
pow.recurse.neg:
	add $a0, $a0, 1 
	jal pow 			# call pow(x, k + 1)
	
	div.s $f0, $f0, $f12 		# $f0 = pow(x, k + 1) / x
	b pow.return			# return
pow.return:	
	lw $ra, 0($sp)			# restore the $ra
	addi $sp, $sp, 4		# restore the stack
	jr $ra				# return
