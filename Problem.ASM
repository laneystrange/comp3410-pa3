array: .word 6,12,5,80
anotherArray: .word 2,5,15,1


#Not all of the hazards could be removed.
.text
la $s1,array	
la $s6,anotherArray		#Loads the second array in $s6


lw $s2, 0($s1)		#Loads the first word in the array and stores it in $s2
lw $s1, 16($s6)		#Loads a word from the $s6 array and store it into $s1
					
addi $s4, $s4, 10	#This is hazard free if we assume forwarding, otherwise it is a small hazard in subi instruction
sub $s6, $s1, $s2	
add $s6, $s2, $s2	#Immediatley overwrites in the WB stage what $s6, but is used two instructions down, which if we can assume
				#forwarding would be unaffected
subi $s5, $s4, 4	#This does not create any further hazards in the program
la $s1, array	#Reloads the array back into $s1, though this does create a hazard that couldn't be avoided since $s6's value
			#still needs to be stored
li   $v0, 10      #This code was placed here, it preps to exit the program, but it is to put off a hazard above further
or  $s3, $s6, $zero	#This code causes no further hazards since the next instruction just uses the same $s6 value and that register
				#isn't hindered
sw  $s6, 12($s1)	#This is the last active instruction and doesn't create anymore hazards



syscall          
