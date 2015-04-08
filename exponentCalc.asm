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
modifyNumber: .float -1
###############################################
#EXPONENT CALCULATION TEXT SECTION
###############################################
	.text
	      l.s $f8,exception1 	#loads 0 in to $f8
      	      l.s $f10,exception2	#loads 1 into $f10
      	      
#GET ARGUMENTS FROM USER
obtainInput: #PROMPT FOR BASE NUMBER
	     li  $v0,4 	       #prep call for displaying string
	     la $a0,promptBase #load propmt for base number
	     syscall 	       #proceed with string display
	     li $v0,6 	       #prep call for collecting an single float (stored in $f0)
	     syscall 	       #proceed with obtaining user input
	     mov.s $f2,$f0     #store base number in $f2
	     c.lt.s $f2,$f8    #if base number < 0
	     bc1t modifyBase
	    
	     #PROMPT FOR EXPONENT
getExp:	     li  $v0,4 	      #prep call for displaying string
	     la $a0,promptExp #load propmt for exponent
	     syscall 	      #proceed with string display
	     li $v0,6 	      #prep call for collecting an single float (stored in $f0)
	     syscall 	      #proceed with obtaining user input
	     mov.s $f4,$f0    #store exponent in $f4
	     c.lt.s $f4,$f8   #if exponent < 0
	     bc1t modifyExp
	     
exponentCalc: #EXPONENT = 0
	      c.eq.s $f4,$f8 #if exponent is 0
	      bc1t zero	     #go to zero code

	      #EXPONENT = 1
	      c.eq.s  $f4,$f10 #if exponent is 1
	      bc1t one	       #go to one code

	      l.s $f12,decrementer #used to modify exponent (during loop)
	      mov.s $f6,$f2	   #move base number to $f6 (for cumulative product)
	      #ELSE EXPONENT > 1
calculation:  sub.s $f4,$f4,$f12 #modify exponent (acting as loop counter)
	      mul.s $f6,$f6,$f2  # $f6 * base number
	      c.eq.s $f4,$f10    #if exponent equal to 1 (repeat calculation)
	      bc1f calculation
	     
	     #DISPLAY RESULT
display:     mov.s $f12,$f6  #load result into $f12
	     li  $v0,4 	     #prep call for displaying string
	     la $a0,result   #load result string
	     syscall	     #proceed with string display
	     li $v0, 2	     #prep call for displaying a single float
	     syscall	     #proceed with float display
	      # EXIT THE PROGRAM CLEANLY
	      li   $v0, 10   # system call for exit
	      syscall               

	###########################################################
	# Subroutine to calculate exponent. 
	###########################################################
one: 	mov.s $f6,$f2 #move base number into result
	b display
	   
zero:   mov.s $f6,$f10 #move zero into result
        b display
  
modifyExp: l.s $f14, modifyNumber  #load -1 into $f14
	   mul.s $f4,$f14,$f4      #make exponent positive
	   div.s $f2,$f10,$f2      #create fraction out of base number
	   b exponentCalc
	   
modifyBase: l.s $f14,modifyNumber
	    mul.s $f2,$f14,$f2	   #make base positive
	    b getExp
