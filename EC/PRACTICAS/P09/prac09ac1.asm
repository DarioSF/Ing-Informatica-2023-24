#########################
# 			#
#	ACTIVIDAD 1	#
# 			#
#########################
.data
vector1: .float 5.6e+20, -5.6e+20, 1.2
vector2: .float 1.2, 5.6e+20, -5.6e+20
.text
la $t0, vector1
lwc1 $f0, 0($t0)
lwc1 $f1, 4($t0)
lwc1 $f2, 8($t0)
add.s $f3, $f0, $f1
add.s $f4, $f2, $f3
la $t1, vector2
lwc1 $f5, 0($t1)
lwc1 $f6, 4($t1)
lwc1 $f7, 8($t1)
add.s $f8, $f5, $f6
add.s $f9, $f7, $f8
