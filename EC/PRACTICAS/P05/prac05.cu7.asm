#########################
# 			#
# 	CUESTION 7	#
# 			#
#########################

.text
li $s0, 1 #Iniciamos contador
li $s1, 11 #Condición de finalización
li $s2,0 #Contador
inicio:	add $s2, $s2, $s0 #cuerpo del bucle
	addi $s0, $s0, 1 #incremento del contador
	sle $t1, $s0, $s1
	beqz $t1, final
	j inicio
final: