# COMP3410 Whatever (Part 3)
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
	la $a0, prompt
	print_str
	
	read_double
	
	round.w.d $f0, $f0
	mfc1.d $a0, $f0
	jal isqrt
	
	move $s0, $v0
	
	la $a0, result
	print_str
	
	move $a0, $s0
	print_int
	
	exit

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
