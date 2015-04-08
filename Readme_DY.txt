Part 1:
I was able to eliminate all pipeline hazards from the code by rearranging different methods to give them enough time to reach a safe step (IF -> ID -> EX -> MEM -> WB). Since all instructions don't require all steps, a few shortcuts could be taken. For example, R-type instructions are safe during the MEM and WB steps, so only 3 instructions were needed before values that needed add, sub, addi, or subi were safe to call.

Part 2:
The program successfully finds positve and negative powers as well as the power of 0, which only returns a 1 since anything to the power of 0 is one. My tests were as follows.

This program will take a base number to a power and give you the result as a floating point number.
Please enter the base number: 
2
Please enter the power: 
-2
The result is: 
0.25

This program will take a base number to a power and give you the result as a floating point number.
Please enter the base number: 
5
Please enter the power: 
3
The result is: 
125.0
-- program is finished running --

This program will take a base number to a power and give you the result as a floating point number.
Please enter the base number: 
10
Please enter the power: 
0
The result is: 
1.0
-- program is finished running --

Part 3:
By using an alogrithm I discovered called "Inverse Fast Square Root," I was able to find the correct rounded value of each square root. 

This program will find the square root of a floating point number, now with double precision! 
Please enter a floating point number: 
20
The approximate square root of your number is: 
4
-- program is finished running --
(Actual value of the square root of 20 is 4.472135955


This program will find the square root of a floating point number, now with double precision! 
Please enter a floating point number: 
9
The approximate square root of your number is: 
3
-- program is finished running --
(Actual value of the square root of 9 is 3)

This program will find the square root of a floating point number, now with double precision! 
Please enter a floating point number: 
1337
The approximate square root of your number is: 
37
-- program is finished running --
(Actual value of the square root of 1337 is: 36.5650105976