#########################
# 			#
# 	CUESTION 14	#
# 			#
#########################
.text 0x00400000
ori $t1, $zero, 0x0000FACE
andi $t2, $t1, 0xf00
andi $t3, $t1, 0x00f
or $t2, $t2, $t3
ori $t2, $t2, 0x0000C0F0