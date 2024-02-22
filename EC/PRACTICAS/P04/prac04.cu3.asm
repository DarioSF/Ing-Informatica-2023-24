#########################
# 			#
# 	CUESTION 3	#
# 			#
#########################
.text 0x00400000
li $t1, 1215261793

li $t2, 0

eti1:
    srl $t3, $t1, 24
    andi $t3, $t3, 0xFF
    move $a0, $t3
    li $v0, 11
    syscall
    sll $t1, $t1, 8
    addi $t2, $t2, 1
    bge $t2, 4, end_loop
    j eti1
end_loop:
    li $v0, 10 
    syscall
