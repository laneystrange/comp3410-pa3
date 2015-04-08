.data
            firstv:  .asciiz "Please input the first value:\n" 
            secondv:  .asciiz "Please input the second value:\n"
            finalv: .asciiz "The final value is: "
            
.text
	#ask for the first value
	 li $v0, 4
         la $a0, firstv
         syscall
	
	#Request input for a integer: 
	li $v0, 5
        syscall
        
        #Store integer in $a1
        add $a1, $zero, $v0
        #----------------------------------------------------
       	#ask for the second value
	li $v0, 4
        la $a0, secondv
        syscall
	
	#Request input for a integer: 
	li $v0, 5
        syscall
        
        #Store integer in $a2
        add $a2, $zero, $v0
        
        #Store integer in $a3
        add $a3, $zero, $a1
        
        addi $t1, $zero, 1
        
loop:   beq $t1, $a2, end
	mult  $a1, $a3 #multiply
	mflo $a3 #move lo to a1
	addi $t1, $t1, 1
	j loop
	
	#print output
end:
	#Print message for final value
	li $v0, 4
        la $a0, finalv
        syscall
	
	li  $v0, 1           
    	add $a0, $a3, $zero  
    	syscall
