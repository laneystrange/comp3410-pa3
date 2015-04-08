.data
 list: .word 3, 0, 1, 2, 6, -2, 4, 7, 3, 7, 3, 0, 1, 2, 6, -2, 4, 7, 3, 7
 list2: .word 1, 2, 6, -2, 4, 7, 3, 7, 3, 0, 1, 2, 6, -2, 4, 7, 23, 42, 41
 
 
 .text
 

##Code was:
##lw $s2, 0($s1)
##w $s1, 16($s6)
##sub $s6, $s1, $s2
##add $s6, $s2, $s2
##or $s3, $s6, $zero
##sw $s6, 12($s1)
##addi $s4, $s4, 10
##subi $s5, $s4, 4

la $s1, list
la $s6, list2
li $s4, 10

lw $s2, 0($s1)


lw $s1, 16($s6) #Unneccessary. Should be removed.
#Not used before the last snippet which needs to use the address stored in $s1


addi $s4, $s4, 10  #moved her to solve the data hazard.

sub $s6, $s1, $s2 #Unneccessary. Should be removed.

add $s6, $s2, $s2	

subi $s5, $s4, 4  #moved her to solve the data hazard.

or $s3, $s6, $zero

la $s1, list #added this load address because otherwise a paradox occurs.
#No matter where you would put this snippet, an out of bounds would occur. 
#s1 gets overwritten earlier in the code by lw s1, 16(s6). 
#and after this we see sw s6, 12(s1), which means s6 needs to access the array referenced in s1.
#No matter which comes first, one will cause an error in the other.

sw $s6, 12($s1)  
#addi $s4, $s4, 10 Was here.
#subi $s5, $s4, 4 Was here.
