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
addi $s4, $s4, 10 #this in between the loads to reduce Data hazard on $s4
lw  $s1, 16($s6)
subi $s5, $s4, 4 #move this to reduce data hazard between $s1 from lw and sub
sub $s6, $s1, $s2 #moved this here to evitate data hazard on $s6 from or instruction
add $s6, $s2, $s2 #Fixed possible structural hazard between sub and this add on $s6 and $s2
or  $s3, $s6, $zero #coudl't fix data hazard here..
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

