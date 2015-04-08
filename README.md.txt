# comp3410-pa3
#Berkeley Willis

Problem 1:
The hazard I was able remove, I had to rearrage much of the code. The first part that I had to do
was to load the array areas into both $s1, and $s6. I also then moved the addi for $s4 under the
second lw instruction that put a value into $s1, this put off the hazard but didn't remove it. Then
$s1-$s2 was placed under that addi instruction. This $s6 value is automatically gets over ridden,
though it's value isn't used yet so this I don't think is an actual hazard, it is just unused garbage
code for now. After the second add instruction that overrides the first $s6 value then $s4 is used to
give value to $s5 from $s4-4. This section presented no hazards, then I reloaded the array into $s1, 
which kinda does present a small hazard because $s1 array is needed before the WB stage. The following
li to $v0 was added, though needed, as padding to push the hazard back even a bit. Then the or 
instruction uses the $s6 value but doesn't produce a hazard because it is just a comparing register. The
last instruction that was left was the sw from $s6 to 12($s1), which since it is the last instruction
presents no hazards. I couldn't find any more ways to take out any more hazards but I am sure there was
a way. The reason why I couldn't is because I couldn't just assume forwarding, which still wouldn't fix
everything, and also that there were few instructions with the same needed registers.

Problem 2:
This problem uses a dialog box that checks the given information to be float, and if it isn't then
it sets a certain value in $a2 which I handle in there. Then it takes in an integer in a similar fashion.
Then it just does a float multiplication of itself using the integer as a counter. It stops branching
back to the loop when appropriate then send out a message box telling the user the evaluation of it.
INPUTS & OUTPUTS:
2.15^5 = 45.940147
1.98723^3 = 7.847736
32.158^2 = 1034.1371
101.2597^7 = 1.09158204E14

Problem 3:
This problem uses a dialog box again to take in a double, a double point percision number. It was
difficult at first to figure out what do do but that was before I looked at all possible double
instructions. Then I figured that I would use the orignal input number, and two double counters
one from the value before and the current value. Then I square the current value and compare it to
the input number. If it is less than or even equal it goes back into the loop using the coprocessor
to branch back, if not it goes to the comparisson of the two. It squares both the current counter, and
the previous counter. Then subracts both of these numbers from the original number. It then takes both
of these numbers, the previous one is not negative and the greater is positive, and adds them together.
It then takes that number and sets the coprocessor to true whether or not this addition is positive or
negative. All during the loops to find a number larger than the input number there has been an integer
counter that has been going on also. It branches or doesn't depending on the added final number, if 
positive it uses previous counter, which is the integer coutner minus one, if not it uses the current
integer's value.
INPUTS & OUTPUTS:
26.25486^(1/2) = 5
41.226^(1/2) = 6
94.22776^(1/2) = 10
12.5456^(1/2) = 4