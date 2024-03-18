#########################
#			#
# 	CUESTION 7	#
# 			#
#########################
.data
A: .space 4
B: .space 4
msg1: .asciiz "Primer numero: "
msg2: .asciiz "Segundo numero: "
.text
la $a0, msg1
li $v0, 4
syscall
li $v0, 5
syscall	
la $a0, A
sw $v0, 0($a0)
la $a0, msg2
li $v0, 4
syscall
li $v0, 5
syscall
la $a0, B
sw $v0, 0($a0) 
la $a0, A
lw $s0, 0($a0)
move $a0, $s0
li $v0, 1
syscall
la $a0, '\n'
li $v0, 11
syscall
la $a0, B
lw $s0, 0($a0)
move $a0, $s0
li $v0, 1
syscall
li $v0, 10
syscall