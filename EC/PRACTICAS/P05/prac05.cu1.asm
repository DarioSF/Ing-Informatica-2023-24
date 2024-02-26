#########################
# 			#
# 	CUESTION 1	#
# 			#
#########################

.text
li $a0, '>'
li $v0,11 #Indicación de escribir un valor
syscall

li $v0,5
syscall #Leer el entero A

bltz $v0, else # Si (A < 0) salta a else
move $a0, $v0 # En $a0 el valor A
j exit #Acaba parte if-then

else:	sub $a0, $zero, $v0 # En $a0 el negativo de A	

exit: 	li $v0, 1 #Imprimir lo que hay en $a0
	syscall
	li $v0, 10 #Acaba el programa
	syscall