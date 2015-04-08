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

Before I get to the sample output, I'd like to embellish on my code a little bit and talk about some ideas that I had.
My original idea was to implement Newton's Method, and I found a way to do it for square roots that only requires one division at the beginning and then bitshifting to divide by two. 
There were a few problems, though: I had to get a good first approximation or else risk running AWAY from the zero of the equation.
I worked out a way to load in the upper word of a double, shift it to gain access to the exponent, and then unweight it and divide by two.
x*10^(y/2) is of the same magnitude as sqrt(x*10^y), so it was a good place to start.
But then I hit another roadblock. You can't bitshift on floating point numbers.
And rightfully so, it only makes sense that you shouldn't mess with the placement of the different portions.
I'd already looked online before for good ways to approximate the square root of a number, but it only worked with integers.
This was a problem, because, as the outputs below show, round(sqrt(2.3)) = 2, but round(sqrt(2.2)) = 1.
sqrt(round(2.3)) and sqrt(round(2.2)) both = 1, on the other hand.
So I used the integer square root on the rounded number to get a very close approximation to the square root.
That became my first estimation for Newton's Method.
The good thing about Newton's Method is that it increases in accuracy quadratically.
Only six cycles are needed to reach extremely high levels of precision.
Not something you'd want to do by hand, but child's play for a computer.
This comes at the cost of doing a division every iteration, but there are so few iterations that I don't view it as a huge shortcoming. Now, on to the output.

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
