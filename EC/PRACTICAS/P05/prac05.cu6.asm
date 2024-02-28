#########################
# 			#
# 	CUESTION 6	#
# 			#
#########################

.text
li $a0, '>'
li $v0,11 #Indicación de escribir un valor
syscall
li $v0,5
syscall #Leer un entero
move $t1, $v0 #Guardamos el entero
li $t2, -5 #entero a comparar

slt $t0, $t1, $t2 
sltu $t3, $t1, $t2
