# COMP3410 Approximate Square Root (Part 3)
# Author: Kieran Blazier
# Assignment: PA[3]
# Date: 4/8/15

# part3.asm
# Input: A double precision floating point value.
# Output: The integer approximation of the square root of the input.
	
	.include "macros.asm"

	.data
	
prompt: .asciiz "Input a decimal number: "
result: .asciiz "The square root is approximately: "

half: .double 0.5

	.text
	
main:
	la $a0, prompt		# write the prompt
	print_str
	
	read_double		# read double input into $f0
	
	round.w.d $f0, $f0	# round the input
	mfc1.d $a0, $f0		# move the rounded input to $a0
	jal isqrt		# $v0 = isqrt($a0)
	
	move $s0, $v0		# save the result
	
	la $a0, result		# write the result message
	print_str
	
	move $a0, $s0		# pass the result
	print_int		# print the result
	
	exit			# exit the program

###############################################
# function: isqrt
# takes --
# $a0 : an integer
# returns --
# $v0 : the integer square root
###############################################
isqrt:
	move $t0, $zero 		# res = 0
	li $t1, 1
	sll $t1, $t1, 30 		# bit = 1 << 30
isqrt.init:
	ble $t1, $a0, isqrt.loop 	# break if !(bit > num)
	srl $t1, $t1, 2 		# bit /= 4
	b isqrt.init			# repeat
isqrt.loop:
	beqz $t1, isqrt.return		# return if bit == 0
	add $t2, $t0, $t1		# $t2 = res + bit
	blt $a0, $t2, isqrt.else	# goto isqrt.else if num < res + bit
	sub $a0, $a0, $t2		# num -= res + bit
	srl $t0, $t0, 1			# res /= 2
	add $t0, $t0, $t1		# res += bit
	b isqrt.continue		# continue
isqrt.else:
	srl $t0, $t0, 1			# res /= 2
isqrt.continue:
	srl $t1, $t1, 2			# bit /= 4
	b isqrt.loop			# repeat
isqrt.return:
	move $v0, $t0			# $v0 = res
	jr $ra				# return
