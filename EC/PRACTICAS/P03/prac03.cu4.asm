#########################
# 			#
# 	CUESTION 4	#
# 			#
#########################
.text 0x00400000
or $a0, '>'
li $v0, 11
syscall

move $a0, $zero

li $v0,12 
syscall
move $a1,$v0 
or $a0, '\n'
li $v0,11
syscall
move $a0, $a1
li $v0, 11
syscall
li $v0, 10 
syscall
