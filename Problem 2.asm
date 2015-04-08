#############################################################################
## I use dialogue boxes instead of the console, the reason for this is     ##
## because that it check the errors for me already, and gives me certain   ##
## trigger values that I will be able to more easily deal with considering ##
## the user fed information is already validated to be either a single     ##
## precision floating point or an integer. It also gives the user the      ##
## the choice and the power to exit out of the program at any time.        ##
#############################################################################

#This section will cary teh null terminated string that will prompt the user for input of a single point percision
#float or an inter depeding the phase. Then of course a promtp to show the answer and to let the user know.
.data
floatPrompt: .asciiz "Please input the single point number you wish to use\nSelect cancel to end the program\n"
intPrompt: .asciiz "Please input the inter that you wish to use\nSelect cancel to end the program\n"

invalidInt: .asciiz "The integer you entered was not valid\nPlease enter a valid integer."
noInt: .asciiz "You didn't enter an integer.\nPlease enter a number to work with."
invalidFloat: .asciiz "The single point float that you entered isn't valid\nPlease enter a valid float."
noFloat: .asciiz "You didn't enter a single point float.\nPlease enter a float to work with."

endPrompt: .asciiz "Your answer is: "

#The start of the program code
.text

#This label and section use a pop up message box to prompt the user and take their single point float number
float:
li $v0, 52	#Preps to use a input message float box
la $a0, floatPrompt	#Loads the message to prompt the user
syscall	#Opens the input message box
beq $a1, -1, InvalidFloat	#If the input give nwas not a float or an incorrectly formatted float
beq $a1, -2, exit	#If the user hits cancel
beq $a1, -3, NoFloat	#If no float was given by the user

#This labe land section use a pop up message box to prompt the user and take their integer
int:
li $v0, 51	#Preps to use a input message int box
la $a0, intPrompt	#Prompts the user with a message
syscall	#Opens the input message box
beq $a1, -1, InvalidInt	#If the integer was not an integer or incorrectly formatted
beq $a1, -2, exit	#If the user selects the cancel option
beq $a1, -3, NoInt	#If there was no int given

#This section is a loop that raises the float to the  power that was given
loop:
addi $a0, $a0, -1	#Decrements the integer to the power
mul.s $f0, $f0, $f0	#Uses a multiply function with single point percision on the number
bgt $a0, 1, loop	#Branches back to the loop if the integer is greater than 1

#The rest of the code merely displays the result of the function
li $v0, 57	#Preps to display the result
mov.s $f12, $f0	#Moves the single point percision float to the correct register to be printed out on a system call
la $a0, endPrompt	#Loads the message that is
syscall	#Displays a final message to the user and their result

exit:
li $v0, 10	#Preps the program to close
syscall	#Closes the program

#The final sections of code are merely if invalid information is recieved, all are formatted the same and comments would all match
#So I just commented the first one that would be true of all, and hopefully they are not needed
InvalidInt:
li $v0, 55	#Preps the message box
la $a0, invalidInt	#Loads the message for the user
syscall	#Opens the message box
b int	#Branches back to the appropriate section

NoInt:
li $v0, 55
la $a0, noInt
syscall
b int

InvalidFloat:
li $v0, 55
la $a0, invalidFloat
syscall
b float

NoFloat:
li $v0, 55
la $a0, noFloat
syscall
b float