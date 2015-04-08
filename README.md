# comp3410-pa3

Part One:

I was able to locate 4 hazards. 

The first one is for lines 22 and 23. The immediate use of $s1 for the lw on line 23 will cause a no-op to occur to wait for line 22 to copmlete. However, with the following code, you can't fix this hazard. Therefore it remains unchanged as seen on lines 37 and 38.

The second one is for lines 23 and 24. Again, the immediate use of $s1 in the sub causes a hazard because it is awaiting the lw of $s1 in the previous line. I swapped lines 24 and 25 as seen in lines 41 and 42 to fix this error.

The third one is for lines 26 and 27. This error is unable to be fixed. If you swap the or and sw instructions you will only get another no-op between those two lines instead of the or and the previous sub instruction.

The fourth one is for lines 28 and 29. These two lines were swapped as seen in lines 49 and 50 to prevent the waiting of $s4 in the subi by the addi.

These were all the hazards I was able to find/fix or not.

Part Two:

(x,k) -> (4.33,3) = 81.18273
	   (120.1, 2) = 14424.01
	   (99.231, -3) = 1.0234293E-6
	   (542.24, -9) = 2.4676072E-25

Part Three:

x	->	4.0 = 2
		5.89 = 2
		500.1234 = 22
		3.99 = 1
		122.3 = 11
		11.11 = 3
		931.9 = 30
