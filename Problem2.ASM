.data
floatPrompt: .asciiz "Enter the single point number you wish to use to Select cancel to end the program"
intPrompt: .asciiz "Enter the  inter that you wish to use to Select cancel to end the program"

invalidInt: .asciiz "Invalid Int. Please enter a valid int."
noInt: .asciiz "Enter a number to work with."
invalidFloat: .asciiz "Th float you entered isn't valid, enter a  valid float."
noFloat: .asciiz "You didn't enter a single point float. Please enter a float to work with."
endPrompt: .asciiz "Your answer is: "

.text

float:
li $v0, 52	
la $a0, floatPrompt	
syscall	#Opens the input message box
beq $a1, -1, InvalidFloat	#If the input give nwas not a float or an incorrectly formatted float
beq $a1, -2, exit	#If the user hits cancel
beq $a1, -3, NoFloat	#If no float was given by the user
#This labe land section use a pop up message box to prompt the user and take their integer
int:
li $v0, 51	
la $a0, intPrompt	
syscall	
beq $a1, -1, InvalidInt	
beq $a1, -2, exit	#If the user selects the cancel option
beq $a1, -3, NoInt	#If there was no int given

loop:
addi $a0, $a0, -1	
mul.s $f0, $f0, $f0	
bgt $a0, 1, loop	

li $v0, 57	
mov.s $f12, $f0	
la $a0, endPrompt	
syscall	#Displays a final message to the user and their result
exit:
li $v0, 10	#Preps the program to close
syscall	#Closes the program

InvalidInt:
li $v0, 55	#Preps the message box
la $a0, invalidInt	#Loads the message for the user
syscall	
b int	
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
