# COMP3410
# Author: Kendal Harris
# Assignment: PA[3]
# Date: 6 April 2015

#REGISTER KEY
# $f0 --> holds syscall inputs
# $f2 --> holds base number
# $f4 --> holds exponent
# $f6 --> holds result
# $f8 --> holds exception 1
# $f10 --> holds exception 2

##########################################################
#EXPONENT CALCULATION DATA SECTION
##########################################################

	.data
promptBase: .asciiz "Please enter a base number.\n" #prompt user to enter input
promptExp: .asciiz "Now enter an exponent.\n" #prompt user to enter input
result: .asciiz "\nThe result is: "
exception1: .float 0
exception2: .float 1
decrementer: .float 1
###############################################
#EXPONENT CALCULATION TEXT SECTION
###############################################
	.text
	      l.s $f8,exception1 	#loads 0 in to $f8
      	      l.s $f10,exception2	#loads 1 into $f10
      	      
#GET ARGUMENTS FROM USER
obtainInput: #PROMPT FOR BASE NUMBER
	     li  $v0,4 #prep call for displaying string
	     la $a0,promptBase #load propmt for base number
	     syscall #proceed with string display
	     li $v0,6 #prep call for collecting an float (stored in $f0)
	     syscall #proceed with obtaining user input
	     mov.s $f2,$f0 #store base number in $f2
	    
	     #PROMPT FOR EXPONENT
	     li  $v0,4 #prep call for displaying string
	     la $a0,promptExp #load propmt for exponent
	     syscall #proceed with string display
	     li $v0,6 #prep call for collecting an float (stored in $f0)
	     syscall #proceed with obtaining user input
	     mov.s $f4,$f0 #store exponent in $f4
	     
exponentCalc: #exponent = 0
	      c.eq.s $f4,$f8 #if exponent is 0
	      bc1t zero

	      #exponent = 1
	      c.eq.s  $f4,$f10 #if exponent is 1
	      bc1t one

	     l.s $f12,decrementer #used to modify exponent
	     mov.s $f6,$f2
	      #else exponent>one
calculation:  sub.s $f4,$f4,$f12 #modify exponent (acting as loop counter)
	      mul.s $f6,$f6,$f2 #store (base num)^2 into $f1
	      #mov.s $f6,$f2 #move cumulative product into result register
	      c.eq.s $f4,$f10 #if exponent equal to 1
	      bc1f calculation
	     
#Show a confirmation of the number selected
display:     mov.s $f12,$f6 #move result into $f12
	     mov.s $f12,$f6 #move result into $f12
	     li  $v0,4 #prep call for displaying string
	     la $a0,result #load propmt for base number
	     syscall #proceed with string display
	     li $v0, 2 #prep call for displaying a float
	     syscall
	      # The program is finished. Exit.
	      li   $v0, 10          # system call for exit
	      syscall               

	###############################################################
	# Subroutine to calculate exponent. Another .data segment.
	###########################################################
one: 	mov.s $f6,$f2 #move base number into result
	b display
	   
zero: mov.s $f6,$f10 #move zero into result
      b display
