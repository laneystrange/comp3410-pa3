# Omer Aldafari
# 4/8/15
# PA3


.data

x : .asciiz "Enter the floating number"
k : .asciiz "\nEnter the exponent"
new: .asciiz "\n"

numone: .float 1.0
#Main body
.text

	la $s0, numone #floating point 1.0
	l.s $f2,($s0) #initializing final result
	
	la $a0,x #print message
	li $v0,4
	syscall 
	
	li $v0, 6 #accepting floating point input from user
	syscall
	# not needed because floating point is in $f0-$f2 move $t0, $v0
	# x is in $f0 and $f1
	
	la $a0,new #making space
	li $v0,4
	syscall 
	
	la $a0,k #printing message exponent
	li $v0,4
	syscall 
	
	li $v0,5
	syscall
	move $t2,$v0 #moving exponent to t2- this is k
	
	#Compute the exponent
	
	addi   $t7,$0,0 # i=0
	
for:    bge  $t7,$t2 end
	blt $t7,$t2 loopmultiply
	
	
loopmultiply:
		mul.s $f2, $f2, $f0 # x*result
		addi $t7, $t7,1 #i++
		j for 

end:
 	li $v0, 2
	mov.s $f12,$f2 
	syscall 
	
	
	
