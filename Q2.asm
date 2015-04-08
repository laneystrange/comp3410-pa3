#Dereje Arega
#COMP3410
#Due Date 4/8/2015

.data
float : .asciiz "Enter the floating number\n"
exponent : .asciiz "Enter the exponent\n"
numone: .float 1.0
negexp: .float 1.0
.text

	la $s0, numone #floating point 1.0
	l.s $f2,($s0) #initializing final result
	
	la $s1, negexp #floating point 1.0
	l.s $f6,($s0) #initializing final result
	
	la $a0,float #print message
	li $v0,4
	syscall 
	
	li $v0, 6 #accepting floating point input from user
	syscall
	# floating point is in $f0-$f1
	# x is in $f0 and $f1

	
	la $a0,exponent #printing message that retrieves exponent
	li $v0,4
	syscall 
	
	li $v0,5
	syscall
	move $t2,$v0 #moving exponent to t2-> this is k
	
	#Compute the exponent
	addi $t3,$zero,-1
	addi   $t7,$0,0 # i=0

	
	blt $t7, $t2, while
 	
	jal fixneg #if we have a neg number we need to make it positive so the 
	#algorithm done for positive numbers work
	
	jal while2
	j negexponent
	
	#first while works for numbers with positive exponent! 
while:   
	bge  $t7,$t2 end # branch to the finish if the counter is equal to exponent x
	blt $t7,$t2 do #otherwise do something brah!
	
	
do:
		mul.s $f2, $f2, $f0 # result
		addi $t7, $t7,1 #i++
		j while
		

	
while2:   
	bge  $t7,$t2 returnAD # branch to the finish if the counter is equal to exponent x
	blt $t7,$t2 do2 #otherwise do something brah!
	
	
do2:
		mul.s $f2, $f2, $f0 # result
		addi $t7, $t7,1 #i++
		j while2 
		

fixneg:

	mul $t2, $t2, $t3
	jr $ra

returnAD:

	jr $ra
	
negexponent: 
	
	div.s $f2, $f6,$f2 #take the inverse


end:
 	li $v0, 2 #syscall variable used for floating point retreaval
	mov.s $f12,$f2  #printing whats in register $f2
	syscall 
