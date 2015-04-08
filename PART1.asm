#Enyil Padilla
.text
lw  $s2, 0($s1)
addi $s4, $s4, 10 #this in between the loads to reduce Data hazard on $s4
lw  $s1, 16($s6)
subi $s5, $s4, 4 #move this to reduce data hazard between $s1 from lw and sub
sub $s6, $s1, $s2 #moved this here to evitate data hazard on $s6 from or instruction
add $s6, $s2, $s2 #Fixed possible structural hazard between sub and this add on $s6 and $s2
or  $s3, $s6, $zero #coudl't fix data hazard here..
sw  $s6, 12($s1)
