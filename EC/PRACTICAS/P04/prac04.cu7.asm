#########################
# 			#
# 	CUESTION 7	#
# 			#
#########################
.text
li $a0, '>'
li $v0,11
syscall
li $v0,5
syscall #Leer un entero
move $a0, $v0 #parámetro a pasar en $a0
jal mult10 #llamamos a la función mult4
move $a0, $v0
jal imprim #Llamamos a la función imprim
li $v0,10 #Acaba el programa
syscall

# Funciones
imprim:
	addi $v0,$0,1 
	syscall 
	li $a0, '\n'
	li $v0,11
	syscall
	jr $ra

mult10: 
	sll $t0, $a0, 3
	sll $t1, $a0, 1
	add $v0, $t0, $t1
	jr $ra 
