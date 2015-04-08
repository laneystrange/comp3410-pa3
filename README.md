PART 1.
Basically, I'm going to be looking for where there is alterations to registers that occur nearby where they are required without
affecting the result of the program. No deletions allowed, only moving the lines.

I moved the superfluous sub $s6 line to the top because it's useless
I spaced out the bottom two in order to space out the dependent stuff above
There's not a lot of cycle perfect stuff, but it will lower the waiting cycles.
The ones on the bottom were hazardous, but not dependent on anything else other than their own order
They will serve as the spacer because of this.
The one moved to the top spaces out the LA to s6 and the add to s6
The one between the "add" and "or" lessen the degree of the hazard

PART 2.
(2, 8) = 256.0
(-4, 20) = -1.09951163E12
(100, -5) = 1.0E-10
(-43.06, -7) = -3.643189E-12

PART 3.
(20) = 4
(300) = 17
(10.69) = 3
(67.2164) = 8
