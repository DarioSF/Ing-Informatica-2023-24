#########################
#			#
# 	ACTIVIDAD 2	#
# 			#
#########################

.data #Definicion segmento de datos
A: .word 25
B: .word 10
C: .word 0

.text #Comienza el programa
la $t0,A
la $t1,B
la $t2,C
lw $s0,0($t0)
lw $s1,0($t1)
add $s2,$s1,$s0
add $s2,$s2,$s2
sw $s2,0($t2)

li $v0, 10 #Acaba el programa
syscall