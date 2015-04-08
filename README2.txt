Part 1:

Hazard 1. 
	On lines 14-16 the lw instruction was reading from memory at the same time the arythmetic calculations in sub were being performed.
	I insereted a nop on line 15 to fix the issue. 

Hazard 2.
	On lines 17-19 the final value for add is stored in $s6 at the WB stage. However, the $s6 register is used as a source in the or function
	before it was written back to in the add function. I insereted a nop on line 18 to fix the issue. 

Hazard 3. 
	On lines 22-24 the s4 register isn't written back to until the WB stage for the addi function. However, the $s4 register is used as a source 
	in the subi function before the $s4 register is written to in the previous addi function. I insereted a nop on line 23 to fix the issue.	

I was able to remove all the hazards. Also, the three hazards I found were Data Hazards. 






Part 2:

5

First Value = 5.0
2

Second Value = 2
25.0
-- program is finished running --

5

First Value = 5.0
5

Second Value = 5
3125.0
-- program is finished running --

42

First Value = 42.0
7

Second Value = 7
2.3053933E11
-- program is finished running --

61

First Value = 61.0
3

Second Value = 3
226981.0
-- program is finished running --

-5.0

First Value = -5.0
2

Second Value = 2
25.0
-- program is finished running --







Part 3:

4.0
2.0
-- program is finished running --

48.7
7.0
-- program is finished running --


3675.8642
61.0
-- program is finished running --


25.1
5.0
-- program is finished running --