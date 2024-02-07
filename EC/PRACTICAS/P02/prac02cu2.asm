#########################
# 			#
# 	PRACTICA 2	#
# 			#
#########################
.text 0x00400000
addi $v0, $0, 5
syscall
addi $a0, $v0, -1
addi $v0, $v0, 1
syscall