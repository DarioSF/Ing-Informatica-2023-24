#########################
#			#
# 	CUESTION 4	#
# 			#
#########################
.data
mensaje: .asciiz "Introduce los elementos del vector B: "
B: .word 0:4
.text
main:
la $s1, B
li $s5, 5 # Tamaño del vector
li $s2, 0 # Inicializar índice del vector
loop:
li $v0, 4
la $a0, mensaje
syscall
add $t2, $s1, $t0
li $v0, 5
syscall
move $t3, $v0 # Guardar valor leído en $t3
sw $t3, 0($t2)
addi $s2, $s2, 1
sll $t0, $s2, 2
bne $s2, $s5, loop
li $v0, 10 # Código de salida del programa
syscall
