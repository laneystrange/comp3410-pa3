#Enyil Padilla Valle
#PART 2
.data
inputx: .asciiz "Please enter an float number x: \n"
inputk: .asciiz "Please enter an integer k: \n"
result: .asciiz "The result is: "
ZEROf: .float 0.0
ONEf: .float 1.0
.text
lwc1 $f1, ZEROf($0) #f1 = 0.0
add $v0, $zero, 4 #prepares print statement
la $a0, inputx #loads message
syscall 
add $v0, $zero, 6 #prepares read float for x
syscall 
add $v0, $zero, 4 #prepares print statement
la $a0, inputk #loads message
syscall
add $v0, $zero, 5 #prepares read int for k
syscall
add $s1, $zero, $v0 #$s1 = k; stores k in $s1
add $t0, $zero, $s1 #$t0 = $s1; stores copy of $s1
bgez $s1, neg #check if x is positive to skip the negative conversion
sub $s1, $zero, $s1 #is negative makes it a positive
neg: #positive k
beqz $s1, zero #if k is 0, then return 1.
add $s1, $s1, -1
add.s $f3, $f1, $f0 #f3 = f0
jal power #jumps to power the number
add $v0, $zero, 2 #prints float result
add.s $f12, $f1, $f0 #loads the float result into f12
syscall
add $v0, $zero, 10 #exits the program
syscall
zero:	#k is 0, return 1 for any number.
lwc1 $f0, ONEf($0) #f1 = 1.0
add $v0, $zero, 2 #prints result
add.s $f12, $f1, $f0 # loads result $f0 into $f12
syscall
add $v0, $zero, 10 #exits the program
syscall
power:
mul.s $f0, $f3, $f0 #"not-really-recursive" multiplies x * (x*...)
add $s1, $s1, -1 #substracts 1 to the iteration
bgtz $s1, power #if $s1 or k > 0 then continue loop
bgtz $t0, pos #check if the original k was negative.
lwc1 $f3, ONEf($0) #f3 = 1.0; loads 1.0 into $f3
div.s $f0, $f3, $f0 #since k < 0, result is 1/result.
pos: jr  $ra #jumps back to main program
