#########################
# 			#
# 	CUESTION 9	#
# 			#
#########################

.text
seguir: li $a0, '>'
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
	add $t0, $t1, $t2 #sumamos A+B
	move $a0, $t0
	li $v0, 1
	syscall #imprimimos A+B
	li $a0, '\n'
	li $v0, 11
	syscall #imprimimos salto de linea
	beqz $t0, salir
	j seguir
salir: