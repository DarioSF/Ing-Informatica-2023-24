#########################
#			#
# 	ACTIVIDAD 1	#
# 			#
#########################

.data # comienza zona de datos
palabra1:.word 15 # decimal
palabra2:.word 0x15 # hexadecimal
madiapalabra1: .half 2
mediapalabra2: .half 6
Dosbytes: .byte 3,4
.align 2 #Alinea la palabra
byte1: .byte 8
byte2: .byte 5
espacio: .space 4 # Reserva 4 bytes a 0
cadena1: .asciiz "Estructura de los computadores"