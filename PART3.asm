#Enyil Padilla Valle
#PART 3
.data
ZEROf: .float 0.0
input: .asciiz "Please enter a positive float number: \n"
.text
start:
lwc1 $f4, ZEROf($0) #f4 = 0.0
la $a0, input
add $v0, $zero, 4
syscall
li $s0, 0 #$s0 = 0
add $v0, $zero, 6 #reads float input
syscall
cvt.w.s $f2, $f0
mfc1 $t0,$f2
bltz $t0, start #checks if input is positive, loops if not
add.d $f0, $f4, $f0 #$f0 double precision
squareRoot:
mul $t0, $s0, $s0 #$t0 = $s0^2
cvt.w.s $f2, $f0 #cast float into int
mfc1 $t1, $f2
beq $t0, $t1, done #if $s0^2 == float number, perfect square, return result
bge $t0, $t1, notquite #if not, not perfect square, fix result to nearest int..
add $s0, $s0, 1 #moves to next iteration, $s0++;
j squareRoot #loop
notquite: #not perfect square...
add $s0, $s0, -1
done: #perfect square...
add $v0, $zero,1 #prints integer result
add $a0, $zero, $s0
syscall #done!
