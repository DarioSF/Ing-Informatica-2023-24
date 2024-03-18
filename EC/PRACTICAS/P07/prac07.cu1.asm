#########################
#			#
# 	CUESTION 1	#
# 			#
#########################
 .data
 str: .ascii "Estructuras de los"
 .asciiz "Computadores"
 msg: .ascii "El número de caracteres de la cadena es: "
 .text
 la $s0, str
 add $s1, $zero, $zero 		# Iniciamos contador a 0
 loop:
add $t0, $s0, $s1		# dirección del byte a examinar
 lb $t1, 0( $t0 )
 beq $t1, $zero, exit 		# salimos si carácter leído='\0'
 addi $s1, $s1, 1 		# incrementamos el contador
 j loop
 exit: 
 la $a0, msg
 li $v0, 4
 syscall 			# Imprimimos mensaje
 move $a0, $s1
 li $v0, 1
 syscall			# Imprimimos el número de caracteres
 li $v0, 10
 syscall
