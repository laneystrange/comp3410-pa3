

.data 
array: .word 0,1,2,3,4,5,6,7,8,9 #array of type int

.text

la $s1, array #loads address of array
la $s6, array #loads address of array

#code being evaluated for hazards...
#I used nop to remove the hazards. This allows the program to execute a null operation so that there are no conflicts resulting in hazards. 
lw  $s2, 0($s1) #load word
lw  $s1, 16($s6) #load word
nop # lw reading from memory the same time the arythimitc calculations in sub are being performed
sub $s6, $s1, $s2 #subtract
add $s6, $s2, $s2 #add
nop # the final value is store in s6 at WB, but the s6 register is used as a source before it has the updated value
or  $s3, $s6, $zero #or
la $s1, array #I added this in #loads the memory address of the array
sw  $s6, 12($s1)#save value to array
addi $s4, $s4, 10 #add immediate
nop # the same issue as above, the s4 register isn't written back to until the WB stage, but the #s4 register is used as a source before the s4 is written to in tbe previous step.
subi $s5, $s4, 4 #subtract immediate
#end code being evaluated for hazards

li $v0, 10
syscall

#the pipeline before any alterations. 
#lw	IF	ID	EX	MEM	WB
#lw		IF	ID	EX	MEM	WB
#sub			IF	ID	EX	MEM	WB
#add				IF	ID	EX	MEM	WB
#or					IF	ID	EX	MEM	WB
#sw						IF	ID	EX	MEM	WB	
#addi							IF	ID	EX	MEM	WB
#subi								IF	ID	EX	MEM	WB
