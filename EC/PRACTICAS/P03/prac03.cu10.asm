#########################
# 			#
# 	CUESTION 10	#
# 			#
#########################
eti1: 	.text
	li $v0, 12
	syscall

eti2:	.text
	move $a0, $v0
	subu $a0, $a0, 48
	li $v0, 1
	syscall
	
	j eti1
	
la $t1, eti1
la $t2, eti2