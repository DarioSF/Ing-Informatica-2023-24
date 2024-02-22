#########################
# 			#
# 	ACTIVIDAD 5	#
# 			#
#########################
.text
eti1:	addi $v0,$0,5
	syscall
eti2: 	addi $a0,$v0,15
	addi $v0,$0,1
	syscall
	
li $a0, '\n'
li $v0,11
syscall
la $t1, eti1 
La $t2, eti2 
move $a0,$t1
li $v0,34
syscall
li $a0, '\n'
li $v0,11
syscall
move $a0,$t2
li $v0,34
syscall
li $v0,10
syscall