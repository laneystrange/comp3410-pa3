Original
 
 lw  $s2, 0($s1)
 lw  $s1, 16($s6)
 sub $s6, $s1, $s2
 add $s6, $s2, $s2
 or  $s3, $s6, $zero
 sw  $s6, 12($s1)
 addi $s4, $s4, 10
 subi $s5, $s4, 4
 
 Correct
 lw $s2, 0($s1)
 lw $s1, 16($s6)
 addi $s4, $s4, 10  #inserted from line 9 - solved hazard1
 sub $s6, $s1, $s2 
 add $s6, $s2, $s2	
 or $s3, $s6, $zero
 #sw $s6, 12($s1)  attempt to remove hazard - non resolved hazard2
 #addi $s4, $s4, 10 moved to 3rd line - solved hazard1
 subi $s5, $s4, 4 
 sw $s6, 12($s1) #non resolved hazard2
 
-So in the end, there was still a hazard present due to $s6.
-However, after moving addi $s4, $s4, 10, it canceled the hazard between the lw $s1, 16($s6) and the sub $s6,$s1,$s2 
+So in the end, there was still a hazard present due to $s1 no longer 
+having an address that can access memory. If one were to use a stack 
+point or reinitialize s1 to the array address, then there would be no hazard here. 
+The nature of the problem asked us to just move instructions