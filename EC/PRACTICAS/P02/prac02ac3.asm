#########################
#			#
#	ACTIVIDAD 3	#
#			#
# #######################
.text 0x00400000
addi $a0, $0, 0
addi $v0, $0, 5
syscall
addi $a0, $v0, 0
addi $v0, $0, 1
syscall
addi $v0, $0, 10
syscall