.data
doubleStart: .double 1.0	
zero: .double 0.0	
doublePrompt: .asciiz "Please enter the number you wish to find the square root of:"
invalidDouble: .asciiz "That is an invalid double"
noDouble: .asciiz "You did not enter a double precision number."

display: .asciiz "The closest integer to the square root of your number is: "

.text

double:
li $v0, 53	
la $a0, doublePrompt	
syscall	
beq $a1, -1, InvalidDouble	
beq $a1, -2, exit	
beq $a1, -3, NoDouble	#If no double or any information was given
bltz $a0, InvalidDouble	#If a doubl less than zero was inputed

l.d $f2, doubleStart	
loop:	
move $t1, $t0	
add.d $f4, $f4, $f2	
add $t0, $t0, 1	#Adds one to the integer that will be the final answer
mul.d $f6, $f4, $f4	#Squares the double value in $f4 so that the it can be compared to the $f6 value
c.le.d $f6, $f0	
bc1t loop	



closer:
sub.d $f4, $f4, $f2	#Decrements the last value of primary double counter to find the value of the counter right before it found
				#a squared value greater than the user's double value
sub.d $f6, $f6, $f0	#Subtracts the user's number from the one greater, resulting no doubt in a positive integer\
mul.d $f4, $f4, $f4	
li $v0, 56	
la $a0, display	#Loads the message to the user saying that the program has found the answer
sub.d $f4, $f4, $f0	
add.d $f8, $f4, $f6	
l.d $f2, zero	#Loads a zero value so the added number may be compared to its value to zero
c.le.d $f8, $f2	
bc1f lessThan	
move $a1, $t0	
syscall	#Displays the resulting values to the user in the message int box
j exit	

lessThan:
move $a1, $t1	#Loads the greater value of the integer from $t0 in an argument register
syscall	#Displays the resulting values to the user in the message intbox

#Kills the program, label is there if a jump to it is needed
exit:
li $v0, 10	#Preps to close the program
syscall	#Closes the program



InvalidDouble:	#If the input double wasn't valid
li $v0, 55	#Preps to open a message box to open
la $a0, invalidDouble	#Loads the appropriate message to be displayed in the box
syscall	#Opens the message box
b double	#Branches back to the double label

NoDouble:
li $v0, 55
la $a0, noDouble
syscall
b double
