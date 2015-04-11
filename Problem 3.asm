#Herve Aniglo
+#My Part 3 for PA3
+
+
+.data
+
+float : .asciiz "Enter a positive integer so we can give you the square root!"
+errormess : .asciiz "Integer is not positive! Try again and get the correct output!\n"
+newline: .asciiz "\n"
+floatzero: .double 0.0
+floatone: .double 1.0
+floatp1: .double 0.1
+floatp5: .double 0.5
+
+.text
+	la $s0, floatzero
+	l.d $f30, ($s0) #This is the result
+	la $s1, floatone
+	l.d $f2, ($s1) #This is used in incrementing
+	la $s2, floatp1
+	l.d $f28, ($s2)
+	
+	la $a0,float #This prints the message
+	li $v0,4
+	syscall
+	 
+checkinput:	
+	li $v0, 7 #This accepts double float point
+	syscall
+
+	
+	la $a0,newline #This makes space
+	li $v0,4
+	syscall
+	
+	c.le.d $f0,$f30 
+	bc1t errormessage
+	
+	j continue
+errormessage:
+		la $a0,errormess #This prints out an error message
+		li $v0,4
+		syscall
+		j checkinput #This go back to accept the input
+
+continue:
+	
+	c.eq.d $f0, $f4 
+	bc1t done
+	c.lt.d $f4,$f0
+	bc1t increment
+	
+	mul.d $f6,$f30,$f30 
+	c.lt.d $f0,$f6
+	bc1t decrement #Its finish but we need to lessen it
+	
+	
+increment:
+	add.d $f30,$f30, $f2 
+	mul.d $f4,$f30,$f30 #The result is stored as the total number
+	j continue
+	
+decrement:
+	sub.d $f30, $f30,$f2
+	mov.d $f24, $f30
+	
+	addi $t2, $0, 0 
+	addi $t3, $0,9 #This continues the limit
+continue2:
+	addi $t2,$t2,1
+	bgt $t2,$t3, check 
+	add.d $f30, $f30, $f28 #adding reult+0.1
+	mul.d $f26, $f30, $f30 
+	c.lt.d $f26,$f0 #if something is wrong, then continue the loop
+	bc1t continue2
+	#Our answer is correct
+	sub.d $f30, $f30,$f28
+	
+check:
+	la $s1, floatp5
+	l.d $f2, ($s1)
+	la $s2, floatone
+	l.d $f28, ($s2)
+	
+	add.d $f30, $f30, $f2 #result + 0.5
+	add.d $f24, $f24, $f28 #c+1
+	
+	c.le.d $f24,$f30
+	bc1f printc 
+	mov.d $f30,$f24	
+	j done
+	
+printc:
+	sub.d $f24, $f24, $f28 #must make it less so the answer can be correct
+	mov.d $f30, $f24
+
+done:
+	#This changes the floating pint to an integer
+	cvt.w.d $f30, $f30
+	mfc1.d $t0, $f30
+	
+	#This prints the final result
+	li $v0, 1
+	move $a0, $t0
+	syscall
+	li $v0, 10
+	syscall
