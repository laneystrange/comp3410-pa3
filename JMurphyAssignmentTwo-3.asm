#‎Babylonian method: The babylonian method is one of the many method to approximate Roots.
#The method uses the following C code:
#	float x = n;
#  	float y = 1;
#  	float e = 0.000001; /* e decides the accuracy level*/
#  	while(x - y > e)
#  	{
#  	  x = (x + y)/2;
#  	  y = n/x;
#  	}

.data
StartingStatment:	.asciiz	   "Please enter a number that you would like to find the square root of: \n"
Answer:		.asciiz	   "Your answer is: \n"
NumberofIterations: .asciiz "Please enter the number of Iteration. Example: 100\n"
ErrorQ: .asciiz "Pleae enter a number which is greater than zero!"
Ended: .asciiz "\n--Ended--"
Checking: .asciiz "\nWorking\n"

Y: .double 1.0
SmallValue: .double 0.000001
Two:		.double 2.0


.text
.globl	main
main:

#printing message for StartingStatment
li	$v0, 4
la	$a0, StartingStatment		
syscall	

li	$v0, 7			
syscall	
		
mov.d $f6, $f0		#$f6 have value
mov.d $f10, $f6		##### convert float to int
cvt.w.d $f10, $f10
mfc1 $t1, $f10		#converted int stored in t1

blt $t1,0,ErrorG

l.d $f4, Y
l.d $f8, SmallValue
l.d $f10, Two

j FindSqaureRoot

FindSqaureRoot:

#$f6 	#x
#f4		 #y 
#f8		#SmallValue

mov.d $f14,$f6 #n

SubtractionChecking:
sub.d $f2,$f6,$f4				#x-y

c.lt.d  $f8,$f2         		# is (x-y) < e?
bc1t    Loop           			#yes:  print(Move towards answer)
bc1f 	Print					#no	:


Loop:

add.d $f6,$f6,$f4				#x+y
div.d $f6,$f6,$f10				#divding it by 2
div.d $f4,$f14,$f6				#n/x

j SubtractionChecking

#Printing the answer!
Print:
mov.d $f12,$f6
li $v0,3
syscall

j EndProgram

#Error that is generated when a number is less than 0!
ErrorG:
li	$v0, 4
la	$a0, ErrorQ		
syscall
	
j EndProgram

EndProgram:
li	$v0, 4			# printing message for xvalue
la	$a0, Ended		
syscall		
	
li $v0,10
syscall
