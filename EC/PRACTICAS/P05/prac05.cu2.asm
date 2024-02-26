#########################
# 			#
# 	CUESTION 2	#
# 			#
#########################

.text

li $a0, '>'
li $v0,11 #Indicación de escribir un valor
syscall

li $v0,5
syscall #Leer el entero A

move $t0, $v0 #Guardamos A

li $a0, '>'
li $v0,11 #Indicación de escribir un valor
syscall

li $v0, 5
syscall #Leer el entero B

move $t1, $v0 #Guardamos B

slt $t0, $t1, $t2 #$t0=1 si $t1<$t2
beq $t0, $zero, eti

move $a0, $t0
li $v0, 1
syscall #Imprimir A
j acabar

eti:	move $a0, $t1
	li $v0, 1
	syscall #Imprimir B

acabar: