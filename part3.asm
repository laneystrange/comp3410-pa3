# Evan Black
# Dr. Strange
# Comp 3410
# April 7th, 2014

.data
onehalf:	.float	0.5
one:		.float	1.0
threehalfs:	.float	1.5
magicnumber:	.word 	1597463007	# Check out "fast inverse square root"
switchoff:	.space	4		# General purpose storage

prompt:		.asciiz "Compute square root of: "
result:		.asciiz "Result: "
errorText:	.asciiz "ERROR - Improper Input!\n"

.text
j 	start

error:
li	$v0, 4		# Get ready to print
la	$a0, errorText	# Adress of string to print
syscall			# Print
	
start:
li	$v0, 4		# Get ready to print
la	$a0, prompt	# Adress of string to print
syscall			# Print

li	$v0, 6		# Get ready to read float
syscall			# Read float

c.lt.s 	$f0, $f31	# If f0 is less than 0, then....
bc1t	error		# Do the error thing

li	$v0, 4		# Get ready to print
la	$a0, result	# Adress of string to print
syscall			# Print

jal	fsr		# Fast square root
jal	round		# Round result
move	$a0, $v0	# Make our result the argument for printing

li	$v0, 1		# Get ready to print int
syscall			# Print int

li	$v0, 10		# Prepare to exit
syscall			# Exit

# This is fast inverse square root, but then I invert it at the end. So uhhh, fast square root, I think?
# This won't work with doubles, as a word's maximum value isn't greater than the magic number needed for 64 bit.
# You would need a 64 bit integer.
fsr:
	addi	$sp, $sp, -28	# Store 7 words
	s.s	$f1, 24($sp)	# for x half
	s.s	$f2, 20($sp)	# For storing .5
	s.s	$f3, 16($sp)	# For storing 1.5
	s.s	$f4, 12($sp)	# For additional work
	sw	$t0, 8($sp)	# Weird shifting goes on here
	sw	$t1, 4($sp)	# Weird shifting goes on here, too
	sw	$t2, 0($sp)	# Magic Number storage
	
	l.s	$f2, onehalf	# Loading our values here and below...
	l.s	$f3, threehalfs
	lw	$t2, magicnumber
	mul.s	$f1, $f0, $f2	# Get X-half
	
	s.s	$f0, switchoff	# Float to Int
	lw	$t0, switchoff
	
	srl	$t1, $t0, 1	# Evil floating point bit level hacking
	sub	$t0, $t2, $t1	# What the fuck?
				# - Some Id Programmer, late 1990s
	
	sw	$t0, switchoff	# Int to Float
	l.s	$f0, switchoff
	
	mul.s	$f1, $f1, $f0	# y = y * x
	mul.s	$f1, $f1, $f0	# y = y * x
	sub.s	$f2, $f3, $f1	# z = z (1.5 at this point) - y
	mul.s	$f0, $f0, $f2	# x = x * z
	
	l.s	$f1, one	# Prepare to invert
	div.s	$f0, $f1, $f0	# Invert
	
	l.s	$f1, 24($sp)	# for x half
	l.s	$f2, 20($sp)	# For storing .5
	l.s	$f3, 16($sp)	# For storing 1.5
	l.s	$f4, 12($sp)	# For additional work
	lw	$t0, 8($sp)	# Weird shifting goes on here
	lw	$t1, 4($sp)	# Weird shifting goes on here, too
	lw	$t2, 0($sp)	# Magic Number storage
	addi	$sp, $sp, 28	# Fix pointer
	
	jr $ra
	
round:
	round.w.s	$f0, $f0	# Round f0
	mfc1 		$v0, $f0	# Convert and move f0 into v0
	jr		$ra		# Jump back to caller