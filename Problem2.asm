#Nathaniel Warren
+#This is my Part 2
+
+
+.data
+float : .asciiz "Enter the floating numbe"
+exponent : .asciiz "Enter the exponent"
+numone: .float 1.0
+negexp: .float 1.0
+.text
+
+	la $s0, numone
+	l.s $f2,($s0) 
+	
+	la $s1, negexp 
+	l.s $f6,($s0) 
+	
+	la $a0,float #This prints the message
+	li $v0,4
+	syscall 
+	
+	li $v0, 6 #This accepts the input from the user
+	syscall
+	
+
+	
+	la $a0,exponent #This is the message telling the user
+	li $v0,4
+	syscall 
+	
+	li $v0,5
+	syscall
+	move $t2,$v0 
+	
+	#This calculates the exponent
+	addi $t3,$zero,-1
+	addi   $t7,$0,0 # i=0
+
+	
+	blt $t7, $t2, while
+ 	
+	jal fixneg 
+	jal while2
+	j negexponent
+	
+	#this works with positive exponents
+while:   
+	bge  $t7,$t2 end # If the counter is eual to exponent x, this is the branch for it
+	blt $t7,$t2 do 
+	
+	
+do:
+		mul.s $f2, $f2, $f0 # The result times x
+		addi $t7, $t7,1 #this increases
+		j while
+		
+
+	
+while2:   
+	bge  $t7,$t2 returnAD # The finishing branch
+	blt $t7,$t2 do2 
+	
+	
+do2:
+		mul.s $f2, $f2, $f0 # The result times x
+		addi $t7, $t7,1 #This increments
+		j while2 
+		
+
+fixneg:
+
+	mul $t2, $t2, $t3
+	jr $ra
+
+returnAD:
+
+	jr $ra
+	
+negexponent: 
+	
+	div.s $f2, $f6,$f2 # This takes the inverse
+
+
+end:
+ 	li $v0, 2 
+	mov.s $f12,$f2  #This prints what is in the register
+	syscall 
