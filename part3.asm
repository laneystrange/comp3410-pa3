# Hien Vo
# COMP3410
# Spring 2015
# Programming Assignment #3 (PA3)
# Assigned: 4/1/15
# Deadline: 4/8/15

.data
	zero_float: .float 0.0
	input: .asciiz "Enter a float number: \n"
	result: .asciiz "Result: \n"
	error_message: .asciiz "Error: your input must be greater than 0. Exiting program \n"

.text

start:
	lwc1 $f4, zero_float($0) 	#load zerofloat (0.0) into $f4
	la $a0, input	
	add $v0, $zero, 4
	syscall
	
	li $s0, 0 
	add $v0, $zero, 6	 #reads float input
	syscall
	cvt.w.s $f2, $f0
	mfc1 $t0,$f2
	bltz $t0, error       	#check if the input is < 0 or not, if it's <0, run the input terminal again
	bgtz $t0, print
	add.d $f0, $f4, $f0     #add loating point
	
error: 	li $v0, 4            #print an error if the input is less than 0
	la $a0, error_message	
	syscall
	
	li $v0, 10
	syscall
	
	
print:			#print result
	li $v0, 4            
	la $a0, result 
	syscall
	
square_root:
	mul $t0, $s0, $s0 		#did the square by multiplying $s0 * $s0 = $s0^2
	cvt.w.s $f2, $f0 		#convert float into integer
	mfc1 $t1, $f2
	beq $t0, $t1, finish		 # check if s0 is perfect square or not, if it is, return to "finish", if it is not return "not"
	bge $t0, $t1, not_perfect	
	add $s0, $s0, 1			 # increase $s0 by 1 each time it runs the loop
	j square_root 			# jumo to "squareroot"
		
not_perfect: 
	add $s0, $s0, -1   #decrease $s0 by 1 to get the closet result
	
	
finish:
	add $v0, $zero,1                #print result in integer
	add $a0, $zero, $s0                	
	syscall
