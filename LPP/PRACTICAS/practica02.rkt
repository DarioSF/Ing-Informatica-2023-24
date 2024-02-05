#lang racket
(require rackunit)

;) EJERCICIO 1
;) A)
(define (binario-a-decimal b3 b2 b1 b0)
  (+ (* b3 (expt 2 3))(* b2 (expt 2 2))(* b1 (expt 2 1))(* b0 (expt 2 0))))

;) TEST
(binario-a-decimal 1 1 1 1) ; ⇒ 15
(binario-a-decimal 0 1 1 0) ; ⇒ 6
(binario-a-decimal 0 0 1 0) ; ⇒ 2

;) B)
(define (binario-a-hexadecimal b3 b2 b1 b0)
  (if(<= (binario-a-decimal b3 b2 b1 b0) 9)
     (integer->char (+ (char->integer #\0) (binario-a-decimal b3 b2 b1 b0)))
     (integer->char (- (+ (char->integer #\A) (binario-a-decimal b3 b2 b1 b0)) 10))))

;) TEST
(binario-a-hexadecimal 1 1 1 1) ; ⇒ #\F
(binario-a-hexadecimal 0 1 1 0) ; ⇒ #\6
(binario-a-hexadecimal 1 0 1 0) ; ⇒ #\A

;) EJERCICIO 2
;(define (cifra-caracter char desplazamiento))

;(define (descifra-caracter char desplazamiento))

;) FUNCIONES AUXILIARES

;) ENCONTRAR INDICE 
(define (encuentra-indice char)
  (- (char->integer char) (char->integer #\a)))
;) TESST
(encuentra-indice #\a)
(encuentra-indice #\t)
(encuentra-indice #\d)

;) ENCONTRAR CARACTER
(define (encuentra-caracter indice)
  (integer->char (+ indice (char->integer #\a))))
;) TEST
(encuentra-caracter 0)
(encuentra-caracter 19)
(encuentra-caracter 3)

;) ESTA ENTRE A Y Z
(define (entre-az? char)
  (and (char>=? char #\a)(char<=? char #\z)))
;) TEST
(entre-az? #\a)
(entre-az? #\z)
(entre-az? #\d)
(entre-az? #\`)


;(define (rota-indice indice desplazamiento))