# COMP3410
# Author: Kendal Harris
# Assignment: PA[3]
# Date: 7 April 2015

####################################
#PART 1 COMMENTS
####################################
Structural Hazards: attempting to use the same 
		    resource by 2+ instructions
	*There was one structural hazard with the sw line.

Control Hazards: attempting to branch before branching
	         conditions have been evaluated
	*There were no control hazards in the code.
	
Data Hazards: attempting to use data before it's ready
	*Nearly all the errors in the code were data hazards.
	*There were data hazards between:Lines 1 and 3,
					Lines 1 and 4,
					Lines 2 and 3,
					Lines 4 and 5,
					Lines 4 and 6, and 
					Lines 7 and 8
	*Most of these were fixed by rearranging the code. However
	some nop instructions could have been added to account for the read 
	after write errors. These are not necessary as Mars will 
	account for these hazards without the nop instruction. 
	*They are commented out just to show where they would have gone.

**Not all the errors could be fixed though. The program runs smoothly 
without the sw instruction, this is due to a structural hazard with the
add line. The sw is trying to start storing $s6, but $s6 is still being 
held in memory.

####################################
#PART 2 COMMENTS
####################################
Values tested:

VALUE SET	RESULT
(2,3)   ------>	8
(2,-3)  ------>	1/8 = 0.125
(3,2)   ------>	9
(-3,-2) ------>	1/9 = 0.11111112

####################################
#PART 3 COMMENTS
####################################
Values tested:

VALUE 		RESULT
  4	------>	2.0
 1225	------>	35.0
  65	------>	8.0
64.1234	------>	8.0