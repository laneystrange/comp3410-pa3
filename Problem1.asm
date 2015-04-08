#I was confused with what I needed to do bebcause I dind't have a sense of direction of what this program was to actually do.

.text
#lw  $s2, 0($s1) 
#lw  $s1, 16($s6)
sub $s6, $s1, $s2 #subtract $s1 from $s2 and put it in $s6
add $s7, $s2, $s2 # add 
or  $s3, $s6, $zero #Bitwise logical ors two registers and stores the result in a register
#sw  $s6, 0($s1) #The contents of $s1 is stored at the specified address.
addi $s4, $s4, 10 #add 10 and $s4 together and put in $s4
subi $s5, $s4, 4 #subtract 4 and $s4 together and put in $s5
