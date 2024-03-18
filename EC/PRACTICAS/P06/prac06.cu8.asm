#########################
#			#
# 	CUESTION 8	#
# 			#
#########################
.data
A: .space 4
B: .space 4
msg1: .asciiz "Primer numero: "
msg2: .asciiz "Segundo numero: "
newline: .asciiz "\n"
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
lw $t0, 0($a0)
la $a0, B
lw $t1, 0($a0)
ble $t0, $t1, skip_swap
move $t2, $t0   # Temporalmente almacenar el valor de A
move $t0, $t1   # Reemplazar el valor de A con el de B
move $t1, $t2   # Reemplazar el valor de B con el de A
skip_swap:
move $a0, $t0
li $v0, 1
syscall
la $a0, newline
li $v0, 4
syscall
move $a0, $t1
li $v0, 1
syscall
la $a0, newline
li $v0, 4
syscall
li $v0, 10
syscall
