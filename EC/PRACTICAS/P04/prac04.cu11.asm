#########################
# 			#
# 	CUESTION 11	#
# 			#
#########################
.text
li $a0, '>'
li $v0,11
syscall
li $v0,5
syscall #Leer un entero
move $a0, $v0 #par�metro a pasar en $a0
jal solv #llamamos a la funci�n mult4
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

solv: 
	sll $t0, $a0, 3
	sll $t1, $a0, 1
	add $t0, $t0, $t1 # 2 � X � 5
	add $t0, $t0, $t1 # (2 � X � 5) + 2 � X
	addi $v0, $t0, 3
	jr $ra 