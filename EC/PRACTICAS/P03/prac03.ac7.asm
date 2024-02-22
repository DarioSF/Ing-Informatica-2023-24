#########################
# 			#
# 	ACTIVIDAD 7	#
# 			#
#########################
.text
eti1: 	addi $v0,$0,5
	syscall
	
eti2: 	addi $a0,$v0,15
	addi $v0,$0,1
	
syscall
li $a0, '\n'
li $v0,11
syscall
j eti1 
