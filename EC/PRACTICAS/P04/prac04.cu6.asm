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
move $a0, $v0 #par�metro a pasar en $a0
jal mult5 #llamamos a la funci�n mult4
move $a0, $v0
jal imprim #Llamamos a la funci�n imprim
li $v0,10 #Acaba el programa
syscall

# Funciones
imprim:
	addi $v0,$0,1 #funci�n imprim
	syscall #Escribe el valor en $a0
	li $a0, '\n' #Salto de l�nia
	li $v0,11
	syscall
	jr $ra #Vuelve al programa principal

mult4: 
	sll $v0, $a0, 2 #Funci�n multiplica entero per 4
	jr $ra 

mult5:
	sll $v0, $a0, 2
	add $v0, $v0, $a0
	jr $ra