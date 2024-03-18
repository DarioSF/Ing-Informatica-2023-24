#########################
#			#
# 	CUESTION 9	#
# 			#
#########################
.data
A: .space 4
B: .space 4
msg1: .asciiz "Primer numero: "
msg2: .asciiz "Segundo numero: "
newline: .asciiz "\n"
.text
# Programa principal
main:
    # Solicitar y almacenar el primer número
    la $a0, msg1
    li $v0, 4
    syscall
    li $v0, 5
    syscall  
    la $a0, A
    sw $v0, 0($a0)
    # Solicitar y almacenar el segundo número
    la $a0, msg2
    li $v0, 4
    syscall
    li $v0, 5
    syscall
    la $a0, B
    sw $v0, 0($a0) 
    # Llamar a la función SWAP para intercambiar los valores en memoria
    la $a0, A
    la $a1, B
    jal SWAP
    # Mostrar el valor de A
    la $a0, A
    lw $a0, 0($a0)
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall
    # Mostrar el valor de B
    la $a0, B
    lw $a0, 0($a0)
    li $v0, 1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # Finalizar el programa
    li $v0, 10
    syscall
    
# Función SWAP
SWAP:
    # Guardar el valor de los registros afectados
    addi $sp, $sp, -8
    sw $t0, 0($sp)
    sw $t1, 4($sp)

    # Cargar los valores de las posiciones de memoria en registros temporales
    lw $t0, 0($a0)
    lw $t1, 0($a1)

    # Intercambiar los valores en las posiciones de memoria
    sw $t1, 0($a0)
    sw $t0, 0($a1)

    # Restaurar los valores de los registros afectados
    lw $t0, 0($sp)
    lw $t1, 4($sp)
    addi $sp, $sp, 8

    jr $ra
