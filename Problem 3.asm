##################################################################################
## This program uses a message input double box to take in a double precision   ##
## floating point into it. From there it checks to make sure that it is a valid ##
## input, and that it is greater than 0 so that it is not negative. After that  ##
## a loop runs that tests, a number that increments, multiple of itself, squared##
## and if the number is greater than the double float then it compares that     ##
## number with the one before it and sees which has a closer answer. When it    ##
## determines this then it simply displays the answer. Again message input boxes##
## do error and validity checking for me, except to make sure that the input is ##
## not negative, but a simple brange if less than can solve this. Can't use     ##
## integers because most of the operations needed to compare to a double ust be ##
## another double so the integer that will be displayed is a secondary coutner  ##
## to the already created double counter which is just incrementing by 1.0		##
##################################################################################

#This section is where all of the prompts and messages to the user are stored at
.data
doubleStart: .double 1.0	#Double that will be the starting point and the incrementer through each step
zero: .double 0.0	#Zero later used for setting a coprocessor's value for the closer routine
doublePrompt: .asciiz "Please enter the positive double point percision number you wish to find the square root of:\n"
invalidDouble: .asciiz "That is an invalid double, or it was formated incorrectly.\nPlease enter a valid double float."
noDouble: .asciiz "You did not enter a double precision number.\nPlease enter a double precision float to use."

display: .asciiz "The closest integer that we can find to\n the square root of your number is: "

.text

double:
li $v0, 53	#Preps the launch of a message input double box
la $a0, doublePrompt	#Loads the message that will prompt the user to enter a double float
syscall	#Launches message input box
#Much error checkign happens the prompts itself
beq $a1, -1, InvalidDouble	#If an improperly formatted double or invalid information was given
beq $a1, -2, exit	#If cancel was selected it branches to exit
beq $a1, -3, NoDouble	#If no double or any information was given
bltz $a0, InvalidDouble	#If a doubl less than zero was inputed

#The rest of the program pre-loads the
l.d $f2, doubleStart	#Gives a double starting value to have compared, after being squared, to the user's double
loop:	#Label of where hte loop starts
move $t1, $t0	#Moves the previous value of $t0 into $t1
add.d $f4, $f4, $f2	#Icrements the $f4 counter by the starting position 1.0
add $t0, $t0, 1	#Adds one to the integer that will be the final answer
mul.d $f6, $f4, $f4	#Squares the double value in $f4 so that the it can be compared to the $f6 value
c.le.d $f6, $f0	#Uses the coprocessor flag value to determine whether or not the loop needs to repeat
				#If the $f6 squared value is less than or equalthe user's double value in $f0 it sets the coprocessor 
				#value to trueFalse if anything else
bc1t loop	#If the coprocessor's value is set to true then it branches back to the loop to have another run done until a value
		#absolutley greater than the user's double is found


#This subroutine is designed to determine which of the two values, the ending greater value or the smaller previous value were
#closer to the user's number. From there it will branch out to the appriopriate section to have integer loaded and then print
closer:
sub.d $f4, $f4, $f2	#Decrements the last value of primary double counter to find the value of the counter right before it found
				#a squared value greater than the user's double value
sub.d $f6, $f6, $f0	#Subtracts the user's number from the one greater, resulting no doubt in a positive integer\
mul.d $f4, $f4, $f4	#Uses the now decremented counter and squares it storing its value inside
li $v0, 56	#Preps to display a message to the user with an integer value
la $a0, display	#Loads the message to the user saying that the program has found the answer
sub.d $f4, $f4, $f0	#Subtracts the lesser squared counter by the uesr's double value, no doubt being negative or zero
add.d $f8, $f4, $f6	#Adds the two greater and lesser values left overs to find which was closer
l.d $f2, zero	#Loads a zero value so the added number may be compared to its value to zero
c.le.d $f8, $f2	#Sets the coprocessor to true if the new added value is less than or equal to $f2(zero)
				#If it is true then its because the negative value was greater, meaning the greater value was closer
				#If it is false then its because the positive value was greater, meaning the lesser value was closer
bc1f lessThan	#Branches if the coprocessor was true on the last c.le.d command
move $a1, $t0	#Loads the previous value of $t0 from $t1
syscall	#Displays the resulting values to the user in the message int box
j exit	#Jumps to the exit section no matter what

#If the lessThan branch was taken
lessThan:
move $a1, $t1	#Loads the greater value of the integer from $t0 in an argument register
syscall	#Displays the resulting values to the user in the message intbox

#Kills the program, label is there if a jump to it is needed
exit:
li $v0, 10	#Preps to close the program
syscall	#Closes the program


#These are user errors and are branched to if input wasn't valid. They repeat so I will comment only on one
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
