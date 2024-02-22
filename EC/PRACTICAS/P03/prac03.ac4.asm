#########################
# 			#
# 	ACTIVIDAD 4	#
# 			#
#########################
.text 0x00400000
li $v0,12 
syscall
move $a1,$v0 
li $v0,11
syscall
li $v0, 10 
syscall