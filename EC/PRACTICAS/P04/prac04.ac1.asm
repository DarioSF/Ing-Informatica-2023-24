#########################
# 			#
# 	ACTIVIDAD 1	#
# 			#
#########################
.text
li $a0, '>' #Comienza programa principal
li $v0,11
syscall
li $v0,5
syscall #Leer un enter
addi $t1,$v0,10
move $a0, $t1 #argumento a pasar en $a0
jal imprim #llamamos a la funci�n
add $t1, $t1,$t1
move $a0, $t1 #argumento a pasar en $a0
jal imprim #llamamos a la funci�n
li $v0,10 #Acaba el programa
syscall

imprim: 
	addi $v0,$0,1 #comienza la funci�n
	syscall #Escribe un valor
	li $a0, '\n' #Salto de l�nia
	li $v0,11
	syscall
	jr $ra #Vuelta al programa principal
