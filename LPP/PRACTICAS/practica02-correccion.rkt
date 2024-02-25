#lang racket
(require rackunit)

;--------------;
; Ejercicio 1: ;
;--------------;

;; Definimos constantes para evitar los "números mágicos"

(define indice-char-0 (char->integer #\0))
(define indice-char-A (char->integer #\A))

(define (binario-a-decimal b3 b2 b1 b0)
  (+ (* b3 (expt 2 3))
     (* b2 (expt 2 2))
     (* b1 2)
     b0))

; Para caclular el carácter hexadecimal de un valor:
; 
; Si el valor es < 10, hay que devolver el carácter
; #\0, #\1, #\2, ..., #\9. Obtenemos el carácter sumándole
; al índice del carácter #\0 el valor.
; Si el valor es >= 10 hay que devolver el carácter
; #\A, #\B, #\C, ..., #\F. Obtenemos el carácter sumándole
; al índice del carácter #\A el incremento (valor - 10).

(define (decimal-a-hexadecimal valor)
  (if (< valor 10)
      (integer->char (+ indice-char-0 valor))
      (integer->char (+ indice-char-A (- valor 10)))))

; Otra solución posible, en el "if" se usa para 
; devolver el valor del índice que hay que convertir
; a carácter:

;(define (decimal-a-hexadecimal valor)
;  (integer->char (if (< valor 10)
;                     (+ indice-char-0 valor)
;                     (+ indice-char-A (- valor 10)))))

(define (binario-a-hexadecimal b3 b2 b1 b0)
  (decimal-a-hexadecimal (binario-a-decimal b3 b2 b1 b0)))

;; Pruebas

(check-equal? (binario-a-decimal 1 1 1 1) 15)
(check-equal? (binario-a-decimal 0 1 1 0) 6)
(check-equal? (binario-a-decimal 0 0 1 0) 2)

(check-equal? (binario-a-hexadecimal 1 1 1 1) #\F)
(check-equal? (binario-a-hexadecimal 0 1 1 0) #\6)
(check-equal? (binario-a-hexadecimal 1 0 1 0) #\A)

;--------------;
; Ejercicio 2: ;
;--------------;


;; Definimos constantes para evitar los "números mágicos"

(define indice-char-a (char->integer #\a))
(define indice-char-z (char->integer #\z))
(define tamaño-alfabeto (+ (- indice-char-z indice-char-a) 1))

;; Funciones

(define (encuentra-indice char)
  (- (char->integer char)
     indice-char-a))

(check-equal? (encuentra-indice #\a) 0)
(check-equal? (encuentra-indice #\b) 1)
(check-equal? (encuentra-indice #\m) 12)
(check-equal? (encuentra-indice #\z) 25)

(define (encuentra-caracter indice)
  (integer->char (+ indice indice-char-a)))

(check-equal? (encuentra-caracter 0) #\a)
(check-equal? (encuentra-caracter 1) #\b)
(check-equal? (encuentra-caracter 12) #\m)
(check-equal? (encuentra-caracter 25) #\z)

(define (entre-az? char)
  (and (char>=? char #\a) (char<=? char #\z)))

(check-true (entre-az? #\a))
(check-true (entre-az? #\m))
(check-true (entre-az? #\z))
(check-false (entre-az? #\`))
(check-false (entre-az? #\{))

(define (rota-indice indice desplazamiento)
  (modulo (+ indice desplazamiento) tamaño-alfabeto))

(check-equal? (rota-indice 4 12) 16)
(check-equal? (rota-indice 4 24) 2)
(check-equal? (rota-indice 4 -5) 25)


(define (cifra-caracter-minuscula char desplazamiento)
  (if (not (entre-az? char))
      char
      (encuentra-caracter (rota-indice (encuentra-indice char) desplazamiento))))

(check-equal? (cifra-caracter-minuscula #\c 5) #\h)
(check-equal? (cifra-caracter-minuscula #\z -1) #\y)
(check-equal? (cifra-caracter-minuscula #\j 40) #\x)
(check-equal? (cifra-caracter-minuscula #\ñ 3) #\ñ)

(define (cifra-caracter char desplazamiento)
  (if (char-upper-case? char)
      (char-upcase (cifra-caracter-minuscula (char-downcase char) desplazamiento))
      (cifra-caracter-minuscula char desplazamiento)))

(check-equal? (cifra-caracter #\D 3) #\G)
(check-equal? (cifra-caracter #\Ñ 3) #\Ñ)


(define (descifra-caracter char desplazamiento)
  (cifra-caracter char (- desplazamiento)))

(check-equal? (descifra-caracter #\d 3) #\a)
(check-equal? (descifra-caracter #\y -1) #\z)
(check-equal? (descifra-caracter #\x 40) #\j)
(check-equal? (descifra-caracter #\tab 3) #\tab)
(check-equal? (descifra-caracter #\G 3) #\D)

;--------------;
; Ejercicio 3: ;
;--------------;

(define (menor-de-tres a b c)
  (if (< a b)
      (if (< a c) a c)
      (if (< b c) b c)))

(define (menor a b)
  (if (< a b) a b))

(define (menor-de-tres-v2 a b c)
  (menor (menor a b) c))

;; Pruebas

(check-equal? (menor-de-tres 2 8 1) 1)
(check-equal? (menor-de-tres 8 2 1) 1)
(check-equal? (menor-de-tres 2 1 8) 1)
(check-equal? (menor-de-tres 8 1 2) 1)
(check-equal? (menor-de-tres 1 8 2) 1)
(check-equal? (menor-de-tres 1 2 8) 1)

(check-equal? (menor-de-tres-v2 3 0 3) 0)
(check-equal? (menor-de-tres-v2 0 3 3) 0)
(check-equal? (menor-de-tres-v2 3 3 0) 0)
(check-equal? (menor-de-tres-v2 3 5 3) 3)
(check-equal? (menor-de-tres-v2 5 3 3) 3)
(check-equal? (menor-de-tres-v2 3 3 5) 3)

;--------------;
; Ejercicio 4: ;
;--------------;

;----;
; a) ;
;----;

(define (f x)
    (cons x 2))

(define (g x y)
    (cons x y))

; Evaluar (g (f (+ 2 1)) (+ 1 1))

; Orden aplicativo:
;
; (g (f (+ 2 1)) (+ 1 1)) -> R3
; (g (f 3)) (+ 1 1)) -> R4
; (g (cons 3 2) (+ 1 1)) -> R3
; (g (3 . 2) (+ 1 1)) -> R3
; (g (3 . 2) 2) -> R4
; (cons (3 . 2) 2) -> R3
; ((3 . 2) . 2)

;; Orden normal

; (g (f (+ 2 1)) (+ 1 1)) -> R4
; (cons (f (+ 2 1)) (+ 1 1)) -> R4
; (cons (cons (+ 2 1) 2) (+ 1 1)) -> R3
; (cons (cons 3 2) (+ 1 1)) -> R3
; (cons (3 . 2) (+ 1 1)) -> R3
; (cons (3 . 2) 2) -> R3
; ((3 . 2) . 2)

;----;
; b) ;
;----;

;; Orden aplicativo 

; (func-2 0 (func-1 10)) -> R4 f
; (func-2 0 (func-1 10 0)) -> R3
; #!error_2ºarg
;
; Se produce un error al intentar evaluar una
; división por cero

;; Orden normal

; (func-2 0 (func-1 10)) -> R4 g
; (if (= 0 0) 0 (func-1 10)) -> R3
; (if #t 0 (func-1 10)) -> Evaluación If
; 0
;
; No se produce un error porque la división por
; cero no se llega a evaluar

;--------------;
; Ejercicio 5: ;
;--------------;

(define (mayor-cadena cadena1 cadena2)
  (if (< (string-length cadena1)
         (string-length cadena2))
      cadena2
      cadena1))

(define (cadenas-mayores lista1 lista2)
  (list (mayor-cadena (first lista1) (first lista2))
        (mayor-cadena (second lista1) (second lista2))
        (mayor-cadena (third lista1) (third lista2))))


;; Pruebas

(check-equal? (mayor-cadena "lisp" "scheme") "scheme")
(check-equal? (mayor-cadena "imperativo" "funcional") "imperativo")

(check-equal? (cadenas-mayores '("hola" "que" "tal") '("meme" "y" "adios"))
              '("hola" "que" "adios"))
(check-equal? (cadenas-mayores '("esto" "es" "lpp") '("hoy" "hay" "clase"))
              '("esto" "hay" "clase"))

;--------------;
; Ejercicio 6: ;
;--------------;


(define (obten-palo caracter)
  (cond
    ((equal? #\♠ caracter) 'Picas)
    ((equal? #\♣ caracter) 'Tréboles)
    ((equal? #\♥ caracter) 'Corazones)
    (else 'Diamantes)))

(define (obten-valor caracter)
  (cond
    ((equal? #\A caracter) 1)  ; As
    ((equal? #\J caracter) 10) ; Jota
    ((equal? #\Q caracter) 11) ; Reina
    ((equal? #\K caracter) 12) ; Rey
    (else (- (char->integer caracter) (char->integer #\0)))))


(define (carta simbolo)
  (cons (obten-valor (string-ref (symbol->string simbolo) 0))
        (obten-palo (string-ref (symbol->string simbolo) 1))))

;; Pruebas

(define tres-de-picas '3♠)
(define as-de-corazones 'A♥)
(define jota-de-diamantes 'J♦)

(check-equal? (obten-palo #\♠) 'Picas)
(check-equal? (obten-palo #\♥) 'Corazones)
(check-equal? (obten-valor #\3) 3)
(check-equal? (obten-valor #\J) 10)

(check-equal? (carta 'A♥) '(1 . Corazones))
(check-equal? (carta '2♦) '(2 . Diamantes))
(check-equal? (carta 'K♣) '(12 . Tréboles))

(check-equal? (carta tres-de-picas) '(3 . Picas))
(check-equal? (carta as-de-corazones) '(1 . Corazones))
(check-equal? (carta jota-de-diamantes) '(10 . Diamantes))



;--------------;
; Ejercicio 7: ;
;--------------;


(define (solo-dos-iguales? d1 d2 d3)
  (and (not (= d1 d2 d3))
       (or (= d1 d2) (= d1 d3) (= d2 d3))))

(define (todos-distintos? d1 d2 d3)
  (and (not (= d1 d2))
       (not (= d1 d3))
       (not (= d2 d3))))

(define (valor-carta c)
  (car (carta c)))

(define (jugada-valores v1 v2 v3)
  (cond
    ((todos-distintos? v1 v2 v3)
     "nada")
    ((not (solo-dos-iguales? v1 v2 v3))
     (string-append "trío de "
                    (number->string v1)))
    (else
     (string-append "pareja de "
                    (if (or (= v1 v2) (= v1 v3))
                        (number->string v1)
                        (number->string v2))))))

(define (jugada-mano carta1 carta2 carta3)
  (jugada-valores (valor-carta carta1)
                  (valor-carta carta2)
                  (valor-carta carta3)))
    

;; Pruebas

;(solo-dos-iguales? d1 d2 d3)
;Ya se probó en Práctica 1 Ejercicio 6

(check-true (todos-distintos? 1 2 3))
(check-false (todos-distintos? 1 1 2))
(check-false (todos-distintos? 1 2 1))
(check-false (todos-distintos? 2 1 1))
(check-false (todos-distintos? 2 2 2))

(check-equal? (valor-carta 'A♥) 1)
(check-equal? (valor-carta '2♦) 2)
(check-equal? (valor-carta 'K♣) 12)

(check-equal? (jugada-mano '3♥ '3♣ '3♥) "trío de 3")
(check-equal? (jugada-mano 'K♦ '7♠ 'K♥) "pareja de 12")
(check-equal? (jugada-mano 'Q♦ 'Q♥ '7♠) "pareja de 11")
(check-equal? (jugada-mano '7♠ 'J♦ 'J♥) "pareja de 10")
(check-equal? (jugada-mano '5♣ '4♣ '6♣) "nada")

