+#This my solution for problem 1.
+.data
+array: .word 40,41,42,43,44,45,46,47
+
+.text
+
+la $s1, array # This loads the array 
+lw $s2, 0($s1)
+la $s6, array# This loads the array
+lw $s1, 16($s6)
+nop # lw read form 
+sub $s6, $s1, $s2
+add $s6, $s2, $s2
+nop #the final value is stored  
+or $s3, $s6, $zero
+la $s1, array # his loads the array
+sw $s6, 12($s1)
+addi $s4, $s4, 10
+nop
+subi $s5, $s4, 4
