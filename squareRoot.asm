# COMP3410
# Author: Kendal Harris
# Assignment: PA[3]
# Date: 7 April 2015

##########################################################
#EXPONENT CALCULATION DATA SECTION
##########################################################
.data

promptArg: .asciiz "Please enter a positive argument.\n" #prompt user to enter input
result: .asciiz "\nThe result is: "
half: .double 2
counterStart: .double 1
zeroRef: .double 0
###############################################
#EXPONENT CALCULATION TEXT SECTION
###############################################
.text
    	      l.d $f2,counterStart #starts the while loop counter at 1
    	      
#GET ARGUMENT FROM USER
obtainInput: #PROMPT FOR ARGUMENT
	     li  $v0,4 	      #prep call for displaying string
	     la $a0,promptArg #load propmt for argument
	     syscall          #proceed with string display
	     li $v0,7 	      #prep call for collecting an double float
	     syscall 	      #proceed with obtaining user input (stored in $f0)
	     c.lt.d $f0,$f2   #check if input < 0
	     bc1t obtainInput
	     
	     
while:	     add.d $f4,$f4,$f2 #increment value (starts at 1)
	     mul.d $f6,$f4,$f4 #square loop counter value
 	     c.le.d $f6,$f0    #check if square value <= user input
	     bc1t while        	#if true repeat until square value > user input
	
finalAnswer: sub.d $f6,$f6,$f0 #revert back to last acceptable squared value (this is double the correct answer) 
	     l.d $f10,half	
	     div.d $f6,$f6,$f10 #divide by 2 (correct answer with decimal)
	     #TRUNCATE RESULT
	     trunc.w.d $f6,$f6
	     cvt.d.w $f6,$f6	#correct final answer
	     
	     #DISPLAY RESULT
display:     mov.d $f12,$f6 	#move result to $f12
	     li  $v0,4 		#prep call for displaying string
	     la $a0,result 	#load result string
	     syscall 		#proceed with string display
	     li $v0, 3 		#prep call for displaying a double float value
	     syscall
	     # EXIT PROGRAM CLEANLY
	      li   $v0, 10      # prep call for program exit
	      syscall           #continue with exiting
