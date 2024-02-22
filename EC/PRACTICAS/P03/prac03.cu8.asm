#########################
# 			#
# 	CUESTION 8	#
# 			#
#########################
eti1: 	.text
	li $v0, 12
	syscall

eti2:	.text
	move $a0, $v0
	addiu $a0, $a0, 32
	li $v0, 11
	syscall
	
la $t1, eti1
la $t2, eti2