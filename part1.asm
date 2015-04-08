# Evan Black
# Dr. Strange
# Comp 3410
# April 8th, 2014

# Evan Black
# Dr. Strange
# Comp 3410
# April 7th, 2014


# Basically, I'm going to be looking for where there is alterations to registers that occur nearby where they are required without
# affecting the result of the program. No deletions allowed, only moving the lines.

# I moved the superfluous sub $s6 line to the top because it's useless
# I spaced out the bottom two in order to space out the dependent stuff above
# There's not a lot of cycle perfect stuff, but it will lower the waiting cycles.
# The ones on the bottom were hazardous, but not dependent on anything else other than their own order
# They will serve as the spacer because of this.
# The one moved to the top spaces out the LA to s6 and the add to s6
# The one between the "add" and "or" lessen the degree of the hazard

.data
	array1:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
	array2:	.word 22, 31, 54, -57, -24, 84, 2, -4, 24, 72, 37
.text

sub	$s6, $s1, $s2	# This line is superfluous, but will cause hazardous stuff if not moved, so I moved it here.

la	$s1, array1
la	$s6, array2	# These are both hazard free! Woopee!

addi 	$s4, $s4, 10	# Moved to separate
lw  	$s2, 0($s1)	# Have to wait a bit for WB on the LA above
lw	$s1, 16($s6)	# Have to wait a bit for WB on the LA above
add	$s6, $s2, $s2	# By this point, s6 should be close to safe to use
subi 	$s5, $s4, 4	# Moved to separate, slightly lessens the degree of the hazard following
or 	$s3, $s6, $zero	# This is fine, because it does not change s6's value, so it doesn't affect the SW below
sw 	$s6, 12($s1)