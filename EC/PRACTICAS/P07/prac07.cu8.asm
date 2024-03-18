#########################
#			#
# 	CUESTION 8	#
# 			#
#########################
.data
matrix: .word 1, 2, 3, 4
        .word 5, 6, 7, 8
        .word 9, 10, 11, 12
        .word 13, 14, 15, 16
sum: .word 0
matrix_ptr: .word matrix
size: .word 4
.text
main:
lw $a0, matrix_ptr
lw $t0, size
li $t1, 0
loop:
mul $t2, $t1, $t0
add $t2, $t2, $t1
sll $t2, $t2, 2
add $t2, $t2, $a0
lw $t3, 0($t2)
add $t4, $t4, $t3
addi $t1, $t1, 1
bne $t1, $t0, loop
li $v0, 1
move $a0, $t4
syscall
li $v0, 10
syscall
