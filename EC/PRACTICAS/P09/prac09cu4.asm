#########################
# 			#
#	CUESTION 4	#
# 			#	
#########################
.data
Array: .float 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
long: .word 10
Suma: .float 0

.text
main:
	la $t0, Array
	lw $t1, long
	li $t2, 0
	li $t3, 0
	
loop:
	beq $t1, $t2, salir
	lwc1 $f1, Array
	add.s $f0, $f1, $f0
	
	addi $t2, $t2, 1
	j loop
	
	

salir:
	div.s $f2, $t1, $t2
	
	
	li $v0, 10
	syscall

