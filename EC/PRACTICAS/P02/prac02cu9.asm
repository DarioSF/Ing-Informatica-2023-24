#########################
# 			#
# 	CUESTION 9	#
# 			#
#########################
.text 0x00400000
addi $v0, $0, 5
syscall
addi $t0, $v0, 0

addi $v0, $0, 5
syscall
addi $t1, $v0, 0

subu  t2, $t0, $t1

addi $a0, $t2, 0
addi $v0, $0, 1
syscall

addi $v0, $0, 10
syscall
