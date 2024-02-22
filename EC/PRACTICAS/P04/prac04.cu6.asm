#########################
# 			#
# 	CUESTION 6	#
# 			#
#########################
.text
li $a0, '>'
li $v0,11
syscall
li $v0,5
syscall #Leer un entero
move $a0, $v0 #parámetro a pasar en $a0
jal mult5 #llamamos a la función mult4
move $a0, $v0
jal imprim #Llamamos a la función imprim
li $v0,10 #Acaba el programa
syscall

# Funciones
imprim:
	addi $v0,$0,1 #función imprim
	syscall #Escribe el valor en $a0
	li $a0, '\n' #Salto de línia
	li $v0,11
	syscall
	jr $ra #Vuelve al programa principal

mult4: 
	sll $v0, $a0, 2 #Función multiplica entero per 4
	jr $ra 

mult5:
	sll $v0, $a0, 2
	add $v0, $v0, $a0
	jr $ra