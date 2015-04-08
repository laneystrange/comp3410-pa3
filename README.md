# comp3410-pa3
# Ben Murphy
####
# Part 1
####
There was surprisingly little work to be done here.
Because the pipeline flushes after five instructions, the hazard and add and the or cause is negated by putting one extra instruction in the top 5.
By putting it between the last lw and the sub, we also avoid a hazard there by making the sub's EX step line up with the lw's WB.
I nop'd out my initial setup to a multiple of five to ensure a clean pipeline for the given instructions, YMMV if you don't do that. 
However, *if* I didn't do that, all I'd have to do is move the subi between the add and the or.
MARS expands subi into addi followed by sub, which takes up two spots.
This ensures the WB from add will be complete for the EX from or.
I didn't want to deal with .data segments so I just made $s1 and $s6 point to -4($sp) and -8($sp) when called with offset 12 and 16, respectively.
Then I stored the stack pointer at 16($s6) to have a valid address for when $s1 is overwritten by 16($s6).

####
# Part 2
####
Sample output:

Floating-point base?: 3.14
Integer power?: 2
Result is 9.859601

Floating-point base?: 7
Integer power?: 8
Result is 5764801.0

Floating-point base?: 0.1
Integer power?: 2
Result is 0.010000001

Floating-point base?: 5.09847345
Integer power?: 6
Result is 17564.71
I mashed random buttons for the decimal on that one. No idea why it turned out so nice.

A few more, to show off negative powers.

Floating-point base?: 16
Integer power?: -2
Result is 0.00390625

Floating-point base?: 3
Integer power?: -2
Result is 0.11111111

####
# Part 3
####

Sample output:

Enter a decimal to get square-rooted: 2.2
The square root rounded to the nearest whole number is: 1

Enter a decimal to get square-rooted: 2.3
The square root rounded to the nearest whole number is: 2

Enter a decimal to get square-rooted: 445675456
The square root rounded to the nearest whole number is: 21111
How do I keep getting neat results when I smash random numbers?

Enter a decimal to get square-rooted: -17.5
Asking me to calculate imaginary square roots? Nah.
