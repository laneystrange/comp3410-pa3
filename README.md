# comp3410-pa3
#Enyil Padilla

PART 1:

lw  $s2, 0($s1) 
Data hazard because of $s1
lw  $s1, 16($s6)
sub $s6, $s1, $s2
Data hazard because of $s6
add $s6, $s2, $s2
or  $s3, $s6, $zero
sw  $s6, 12($s1)
Data hazard because of $s4
addi $s4, $s4, 10
subi $s5, $s4, 4


lw  $s2, 0($s1)
addi $s4, $s4, 10
lw  $s1, 16($s6)
subi $s5, $s4, 4
sub $s6, $s1, $s2
add $s6, $s2, $s2
or  $s3, $s6, $zero
sw  $s6, 12($s1)

Got rid of the data hazards if pipeline is less than 5, but I think some structural hazards remained...
I don't know why! D':

PART 2:
(3,2) = 9.0
(3,-2) = 0.11111111
(9,3) = 729.0
(-9,3) = -729.0

PART 3:
5.89 = 2
4.0 = 2
500.1234 = 22
739.5685 = 27

