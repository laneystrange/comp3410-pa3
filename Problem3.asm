.data
linebreaker: .asciiz "\n"
askdouble: .asciiz "Enter a double.\n"
answer: .asciiz "Answer is:\n"
fsquare: .double 0.0
fone: .double 1.0
f0.5: .double 0.5


.text
li $v0, 4
la $a0, askdouble ##Ask user for a double (double-precision)
syscall


li $v0, 7 #user enters double
syscall


l.d $f8, fsquare	#holds the square used throughout
l.d $f6, fone           #holds a constant 1.0 value to be used.
l.d $f10, f0.5
#f0 is user input 

SQR:
add.d $f8, $f8, $f6	#increments the number to be squared by 1.0 each time.
mul.d $f2, $f8, $f8

c.eq.d $f2, $f0
bc1t CONT
c.lt.d $f2, $f0
bc1t SQR


   

sub.d $f8, $f8, $f6	#sets it so that the number squared by itself is at least less than or equal
			#to the number given by the user.
add.d $f8, $f8, $f10	#add 0.5 to determine if the number needs to be rounded up or down.
mul.d $f2, $f8, $f8
c.lt.d $f2, $f0
bc1t RoundUp
sub.d $f8, $f8, $f10  #number was found to not need rounding up. Returned to initial value.
j CONT

RoundUp:
add.d $f8, $f8, $f10   #finish rounding up.



CONT:
mov.d $f12, $f8 #move double into register to print
li $v0, 4
la $a0, linebreaker
syscall

la $a0, answer #tell user the following is the answer
syscall

li $v0, 3
syscall

li $v0, 10 #end program
syscall
 