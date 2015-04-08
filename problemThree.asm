# Robert L. Edstrom
# COMP3410 PA3
# Problem Three
# 4/7/15

# Used Newton's Method to calculate the sqrt of a floating point value to it's closest approximated value
# x' = (1/2)(x + n/x)

	.data

message:	.asciiz "Enter a floating point value: "
answer:		.asciiz "The answer is:	"	
constantOne:	.float	1.0	
constantTwo:	.float	2.0
constantThree:	.float	1.0
constantFour:	.float	1.0e-5


        .text
       
init:
	la	$a0, message
	li	$v0, 4
	syscall	
	
        li 	$v0, 6
        syscall  

        l.s	$f1,  constantOne       # Load the constant 1.0 into register $f1
        l.s   	$f2,  constantTwo       # Load the constant 2.0 into register $f2
        l.s    	$f3,  constantThree     # Load the first approximated value into register $f3
        l.s    	$f10, constantFour	# Load the minimum approximation into register $f10

loop:   
        mov.s   $f4, $f0             	# $f4 = user input
        div.s   $f4, $f4, $f3         	# $f4 = n/x
        add.s   $f4, $f3, $f4         	# $f4 = x + n/x
        div.s   $f3, $f4, $f2         	# $f3 = (1/2)(x + n/x)

        mul.s   $f6, $f3, $f3         	# $f6 = x^2
        div.s   $f6, $f0, $f6         	# $f6 = n/x^2
        sub.s   $f6, $f6, $f1         	# $f6 = n/x^2 - 1.0
        abs.s   $f6, $f6             	# $f6 = |n/x^2 - 1.0|
        c.lt.s  $f6, $f10            	# Check: $f6 = |x^2 - n| < small
        bc1t    print               	# If true then we have reached the approximated value i.e. | n/x*x - 1 |  <  0.00001
  
        j       loop                	# Else we havn't reached the approximated value i.e. | n/x*x - 1 |  >  0.00001
        
print:
	la	$a0, answer
	li	$v0, 4
	syscall
	
       	mov.s	$f12, $f3            	# Print the result
        li	$v0, 2			# Setup for printing the value
        syscall				# Print the value

exit:                
        li	$v0, 10			# Setup for clean exit
        syscall				# Exit
