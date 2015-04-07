# COMP3410
# Author: Kendal Harris
# Assignment: PA[3]
# Date: 6 April 2015

#REGISTER KEY
# $f0 --> holds syscall inputs
# $f2 --> holds base number
# $f4 --> holds low value

##########################################################
#EXPONENT CALCULATION DATA SECTION
##########################################################

	.data
promptArg: .asciiz "Please enter a positive argument.\n" #prompt user to enter input
result: .asciiz "\nThe result is: "
const: .double 2
reference: .double 1
###############################################
#EXPONENT CALCULATION TEXT SECTION
###############################################
	.text
	
	l.d $f4, reference	#lowest value starts at 1
	l.d $f14,const		#load 2 into $f14
      	      
#GET ARGUMENTS FROM USER
obtainInput: #PROMPT FOR ARGUMENT
	     li  $v0,4 #prep call for displaying string
	     la $a0,promptArg #load propmt for base number
	     syscall #proceed with string display
	     li $v0,7 #prep call for collecting an double float (stored in $f0)
	     syscall #proceed with obtaining user input
	     mov.s $f2,$f0 #store argument in $f2
	     mov.s $f16, $f2 #make a copy of input
	    
	#move $t1, $t0		#Moves the previous value of $t0 into $t1
while:	sub.d $f6, $f16, $f4	#hi-lo
	add.d $f8, $f4, $f6	# $f8 = $f4 + $f6
if:	div.d $f8, $f8, $f14	# $f8 = lo+ (hi-lo)/2 -->mid value
	sub.d $f10, $f8, $f2	# $f10 = $f8 - $f2 -->mid - input
	mul.d $f12, $f8, $f10	# mid * mid -input
	c.le.d $f12, $f4	#check mid * mid-input <=1
					# if so --> hi = mid
					# if not --> lo = mid
	bc1f greater		#if so --> hi = mid
	bc1t less		#if not --> lo = mid
continue: c.le.d $f6,$f4	# check hi - lo<=1
	  bc1f while		#means hi-lo > 1 -->repeat while loop
	
	#at end of loop lo is in $f4 --> return lo
	     
#Show a confirmation of the number selected
display:     mov.s $f12,$f4 #move result into $f12
	     #mov.s $f12,$f6 #move result into $f12
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
greater: 	mov.s $f16,$f8 #hi =mid
		b continue
	   
less: mov.s $f4,$f8 #lo = mid
      b continue