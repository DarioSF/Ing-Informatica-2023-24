#########################
# 			#
# 	CUESTION 5	#
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

sgt $t0, $t1, $t2
sge $t3, $t1, $t2
ble $t1, $t2, eti

eti:	li $a0, 'L'
	li $v0 11
	syscall