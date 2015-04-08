Problem 1:
+
+There were a few problems. 
+la $s1, array #loads array 
+lw $s2, 0($s1)
+la $s6, array# loads array
+lw $s1, 16($s6)
+nop
+sub $s6, $s1, $s2
+
+The final value that is needed is stored in WB, but $s6 is used as a source before it is updated.
+
+
+Results for Part 2:
+Enter the floating number
+-9.022
+Enter the exponent
+2
+81.39649

+Results Part 3:
+Enter a positive floating number that will have square root taken
+68.798
+
+8
+The program stopped
+
+Enter a positive floating number that will have square root taken
+-100
+
+Number was not positive; please try again
+The program stopped
