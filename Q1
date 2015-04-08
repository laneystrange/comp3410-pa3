.data
	numone: .word 1

.text
	la $s1,numone # This does not have any dependance with other instructions
	lw  $s2, 0($s1) #lw mean loading the data from memory to registor
	addi $s4, $s4, 10 # To elimenat stall i move this instraction here and use forwarding hazard ilimenation
	lw  $s1, 16($s6) # Use forwarding
	sub $s6, $s1, $s2 # Use forwarding
	add $s6, $s2, $s2# Use forwarding
	or  $s3, $s6, $zero# Use forwarding
	sw  $s6, 12($s1)# Use forwarding
	subi $s5, $s4, 4 # this instruction depend one $s4, $s4, 10 therefore it could not have hazard
	
