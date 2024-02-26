#########################
# 			#
# 	CUESTION 8	#
# 			#
#########################

.text
inicio:	li $a0 '>'
	li $v0, 11
	syscall
	li $v0, 5
	syscall
	beqz $v0, final
	add $t0, $t0, $v0
	move $a0, $t0
	li $v0, 1
	syscall
	li $a0, '\n'
	li $v0, 11
	syscall
	j inicio

final: li $v0, 10
	syscall