.data

zero: .double 0.0 #double precision float in memory
one: .double 1.0 #value stored in memory
half: .double 0.5 #value stored in memory
errorMsg: .asciiz "You entered an invalid numberl try again.\n" 
answer: .double 0 #memory location for final answer
 
.text
calculateSqrt: #subroutine


la $v0, 7  #read in a double precision float
syscall #read a double precision float float
#f0 contains the float gotten from the user
l.d $f4, zero #load 0 to f0 

c.lt.d $f0, $f4 # if less than 0 cause an error 
bc1t ERROR #branch to error

mov.d $f2, $f0 #move float to f2

round.w.d $f2, $f2  #round the value in f2
cvt.d.w $f2, $f2 #convert the value to an int 

l.d $f6, one #load 1 to f6
l.d $f8, one #load 1 to f08

loop: #loop
	mul.d $f10, $f6, $f6 # multiply f6 by itself and save the value in f10
	c.lt.d $f2, $f10 #compare the rounded value from the user to f6 
	bc1t finishCalc #branch if the f3 is less than f10
        add.d $f6, $f6, $f8 #increment the value in f6 
	j loop #jump back to loop 
 	

finishCalc:
	sub.d $f6, $f6, $f8 #subtract to get the acutal square root
	j end #jump to end 
	
ERROR: #error handler
	li $v0, 4 #prepare to print string
	la $a0, errorMsg
	syscall#print
	j calculateSqrt  #jump back to top at the beginning of the subroutine
	
end: #handles the ending
	l.d $f0, half #loads .5 to f0
	add.d $f8, $f6, $f0 #adds .5 to f8 
	mul.d $f10, $f8, $f8 #calculates the altered value
	c.lt.d $f10, $f2 #if less than, the nwe know to round the altered value to the next highest int. 
	bc1t roundAnswer #jump to this label to finish rounding.
	j endFinal #end without rounding

roundAnswer:
	l.d $f8, one #load 1 to f08
	add.d $f6, $f6, $f8 #add one to f6

endFinal:
	
	round.w.d $f6, $f6 #round f6
	cvt.d.w $f6, $f6 #convert f6 to an int
	s.d $f6, answer #save the value of f6 in memory
	
	li $v0, 3 # prepare to print
	mov.d $f12, $f6 #move the value of f6 to f12
	syscall
	
	li $v0, 10 #close program 
	syscall #end program
	
	
	
	
