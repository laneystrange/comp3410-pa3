.data
            firstv:  .asciiz "Please input the number you want to get the square root of:\n" 
            finalv:  .asciiz "The value is: " 
            error: .asciiz "Wrong value entered!!!"
            
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
        
loop:   beq $t1, $a2, end
	mult  $a1, $a3 #multiply
	mflo $a3 #move lo to a1
	addi $t1, $t1, 1
	j loop
	

errort:
	#Print message for final value
	li $v0, 4
        la $a0, error
        syscall

    	j end2
    	
end:
	#Print message for final value
	li $v0, 4
        la $a0, finalv
        syscall
	
	li  $v0, 1           
    	add $a0, $a3, $zero  
    	syscall

end2:
