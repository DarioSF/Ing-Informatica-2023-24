#########################
# 			#
#	CUESTION 5 	#
# 			#
#########################
.data
Xpide: .asciiz "X = "
Npide: .asciiz "n = "
powRes: .asciiz "X^n = "
.text
la $a0, Xpide
li $v0,4
syscall
li $v0,6
syscall
la $a0, Npide
li $v0,4
syscall
li $v0,5
syscall
mov.s $f12,$f0
move $a0,$v0
jal pow
la $a0,powRes
li $v0,4
syscall
mov.s $f12,$f0
li $v0,2
syscall
li $v0,10
syscall
 pow:
li $t0, 1
C O M P L E T A R
jr $ra
