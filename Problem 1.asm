##############################################################################################
## The original colde, with out the loading of the arrays and not repositioning yet. 	  ##
##############################################################################################
## lw  $s2, 0($s1) --> load value in $s1 offset 0, into $s2							  ##
## lw  $s1, 16($s6) --> load value in $s6 offset 16, into $s1						  ##
## sub $s6, $s1, $s2 --> $s6 = $s1 - $s2										  ##
## add $s6, $s2, $s2 --> $s6 = $s2 + $s2										  ##
## or  $s3, $s6, $zero --> bitwise or $s6 with zero (keeps $s6 the same), stores in $s3	  ##
## sw  $s6, 12($s1) --> store value in $s1 offset 12, into $s6						  ##
## addi $s4, $s4, 10 --> $s4 = $s4 + 10											  ##
## subi $s5, $s4, 4 --> $s5 = $s4 - 4											  ##
###############################################################################################
#Area where the arrays are stored and also where their original values are held
.data
array: .word 6,12,5,80
anotherArray: .word 2,5,15,1


#Not all of the hazards could be removed, I'll point them out, but the reasoning is that with out more garbage code or nops or even
#without being able to assume that MIPS uses a type of forwarding it was difficult to take out all of the hazards. Another factor
#that I needed to think about was to store the same value into $s1 again from $s6, which was $s2+$s2 in the original code.
.text
la $s1,array	#Loads the address for the first array in $s1
la $s6,anotherArray		#Loads the second array in $s6

#This is where the most altered code is located
lw $s2, 0($s1)		#Loads the first word in the array and stores it in $s2
lw $s1, 16($s6)		#Loads a word from the $s6 array and store it into $s1
					#Though this does present a large hazard that can only be solved by bubbling or nops to get to the 
					#next snippet's since the new value of $s1 is used in it. Couldn't be removed because I also need to
					#reload the array back into $s1 after it has been used in the sub instruction
addi $s4, $s4, 10	#This is hazard free if we assume forwarding, otherwise it is a small hazard in subi instruction
sub $s6, $s1, $s2	#Holds up $s6's value for the next op, but the value isn't used, the other two aren't used after their values
				#have been taken into the ALU, and their register's aren't needed again. The 
add $s6, $s2, $s2	#Immediatley overwrites in the WB stage what $s6, but is used two instructions down, which if we can assume
				#forwarding would be unaffected
subi $s5, $s4, 4	#This does not create any further hazards in the program
la $s1, array	#Reloads the array back into $s1, though this does create a hazard that couldn't be avoided since $s6's value
			#still needs to be stored
li   $v0, 10      #This code was placed here, it preps to exit the program, but it is to put off a hazard above further
or  $s3, $s6, $zero	#This code causes no further hazards since the next instruction just uses the same $s6 value and that register
				#isn't hindered
sw  $s6, 12($s1)	#This is the last active instruction and doesn't create anymore hazards


#The last section is just to exit out of the program
syscall           #continue with exiting