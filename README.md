# comp3410-pa3


Question 1:

There were a few hazards that had to be dealt with concerning the code. 
la $s1, array #loads array 
lw $s2, 0($s1)
la $s6, array# loads array
lw $s1, 16($s6)
nop
sub $s6, $s1, $s2
This lw read from memory at the same time as the sub is doing the calculation

Also as the code continues, the final value that is needed is stored in WB, but $s6 is used as a source before it is updated.


Question 2:

This program rewrites a subroutine in MIPS that computes an exponent x^k, where x is a floating number. Both of this can be negative or positive:

Input:5, 2
Output: 25.0

Input-2, 2
Output:4


Input: 5.0, 3
Output:125.0

Question 3:

This problem writes a subroutine in Mips that approximates the square root of a floating-point number with (double-precision) and stores the rsult as an int.

Input:6
Output:2.0


Input:7
Output:3.0


Input:100
Output:10.0
