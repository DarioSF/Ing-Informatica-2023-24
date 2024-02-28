#########################
# 			#
# 	CUESTION 10	#
# 			#
#########################

.text
pedir:	li $a0, '>'
	li $v0,11 #Indicación de escribir un valor
	syscall
	li $v0,5
	syscall #Leer A
	move $t1, $v0 #Guardamos A
	li $a0, '>'
	li $v0,11 #Indicación de escribir un valor
	syscall
	li $v0,5
	syscall #Leer B
	move $t2, $v0 #Guardamos B
	bgt $t1, $t2, pedir
	
for:	move $a0, $t1
	li $v0, 1
	syscall #imprimir el numero
	li $a0, '\n'
	li $v0, 11
	syscall #imprimimos salto de linea
	sub $t2, $t2, 1 #restar contador
	addi $t1, $t1, 1 #aumentamos el valor a imprimir
	beqz $t2, final
	j for
	
final:
