#########################
# 			#
# 	CUESTION 10	#
# 			#
#########################
.text
li $a0, '>'
li $v0,11
syscall
li $v0,5
syscall #Leer un entero
move $a0, $v0 #par�metro a pasar en $a0
jal mult11 #llamamos a la funci�n mult4
move $a0, $v0
jal imprim #Llamamos a la funci�n imprim
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

mult11: 
	sll $t0, $a0, 4
	sll $t1, $a0, 3
	sll $t2, $a0, 2
	sub $t3, $t0, $t1
	add $t0, $t3, $t2
	sub $v0, $t0, $a0
	jr $ra 