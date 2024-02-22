#########################
# 			#
# 	CUESTION 4	#
# 			#
#########################
.text 0x00400000
jal read
jal cuadrup
jal imprim
li $v0, 10
syscall

read:	li $v0, 5
	syscall
	move $t1, $v0
	li $a0, '\n'
	li $v0, 11
	syscall
	jr $ra 

cuadrup: 
	add $t1, $t1, $t1
	add $t1, $t1, $t1
	move $a0, $t1
	jr $ra

imprim: 
	addi $v0,$0,1
	syscall
	li $a0, '\n'
	li $v0,11
	syscall
	jr $ra 
	
