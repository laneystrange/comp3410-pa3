#Frank Martino
#4/7/2015
#Part One fixing scheduling for the code

.data 
array:		.word 5, 7, 13, 11, 43, 20, 19
otherArray:	.word 65, 7, 99, 54, 36


.text 
li	$s4, 2			#load 2 into s4
la	$s1, array		#load the array address into $s1
la 	$s6, otherArray	#load the other array address into $s6


lw  	$s2, 0($s1)		#load first value from array into $s2
lw  	$t1, 16($s6)		#load 4th value from otherarray into $t1

#sub 	$t6, $t1, $s2		#command removed as its answer is unessacary as it is overwritten by next command
add 	$t6, $s2, $s2		#double s2 and store it into $t6
addi	$s4, $s4, 10		#add 10 into s4 ( moved to help elimnate hazard in previous and following commands
or 	$s3, $t6, $zero		#or T6 and 0
sw  	$t6, 12($s1)		#save the value from t6 to 12(s1)

subi 	$s5, $s4, 4		#subtract 4 from s4 store in s5

li	$v0, 10
syscall	
