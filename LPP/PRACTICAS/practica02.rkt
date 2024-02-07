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
     (integer->char
      (+ (char->integer #\0) (binario-a-decimal b3 b2 b1 b0)))
     (integer->char
      (- (+ (char->integer #\A) (binario-a-decimal b3 b2 b1 b0)) 10))))

;) TEST
(binario-a-hexadecimal 1 1 1 1) ; ⇒ #\F
(binario-a-hexadecimal 0 1 1 0) ; ⇒ #\6
(binario-a-hexadecimal 1 0 1 0) ; ⇒ #\A

;)-------------------------------------------------------------------

;) EJERCICIO 2

;) FUNCIONES AUXILIARES

;) ENCONTRAR INDICE 
(define (encuentra-indice char)
  (- (char->integer char) (char->integer #\a)))
;) TESST
(encuentra-indice #\a) ; ⇒ 0
(encuentra-indice #\b) ; ⇒ 1
(encuentra-indice #\m) ; ⇒ 12
(encuentra-indice #\z) ; ⇒ 25

;) ENCONTRAR CARACTER
(define (encuentra-caracter indice)
  (integer->char
   (+ indice (char->integer #\a))))
;) TEST
(encuentra-caracter 0) ; ⇒ #\a
(encuentra-caracter 1) ; ⇒ #\b
(encuentra-caracter 12) ; ⇒ #\m
(encuentra-caracter 25) ; ⇒ #\z

;) ESTA ENTRE a Y z
(define (entre-az? char)
  (and (char>=? char #\a)(char<=? char #\z)))
;) TEST
(entre-az? #\a) ; ⇒ #t
(entre-az? #\m) ; ⇒ #t
(entre-az? #\z) ; ⇒ #t
(entre-az? #\`) ; ⇒ #f
(entre-az? #\{) ; ⇒ #f

;) ESTA ENTRE A Y Z
(define (entre-mayus-az? char)
  (and (char>=? char #\A)(char<=? char #\Z)))
;) TEST
(entre-mayus-az? #\A) ; ⇒ #t
(entre-mayus-az? #\M) ; ⇒ #t
(entre-mayus-az? #\Z) ; ⇒ #t
(entre-mayus-az? #\`) ; ⇒ #f
(entre-mayus-az? #\{) ; ⇒ #f

;) ROTAR EL CARACTER
(define (rota-indice indice desplazamiento)
  (if(< 0 (+ indice desplazamiento))
        (- (+ indice desplazamiento) 26)
        (+ indice desplazamiento 26)))
;) TEST
(rota-indice 4 24) ; ⇒ 2)
(rota-indice 4 -5) ; ⇒ 25)

;) FUNCION CIFRADO
(define (cifra-caracter char desplazamiento)
  (cond
    ((entre-az? char)
     (encuentra-caracter
      (modulo
       (rota-indice
        (encuentra-indice char) desplazamiento)
       26)))
    ((entre-mayus-az? char)
     (char-upcase
      (encuentra-caracter
       (modulo
        (rota-indice
         (encuentra-indice
          (char-downcase char)) desplazamiento)
        26))))
    (else char)))
;) TEST
(cifra-caracter #\c 5) ; ⇒ #\h)
(cifra-caracter #\z -1) ; ⇒ #\y)
(cifra-caracter #\j 40) ; ⇒ #\x)
(cifra-caracter #\D 3) ; ⇒ #\G)
(cifra-caracter #\ñ 3) ; ⇒ #\ñ)

;) FUNCION DESCIFRADO
(define (descifra-caracter char desplazamiento)
  (cond
    ((entre-az? char)
     (encuentra-caracter
      (modulo
       (rota-indice
        (encuentra-indice char)
        (- 0 desplazamiento))
       26)))
    ((entre-mayus-az? char)
     (char-upcase
      (encuentra-caracter
       (modulo
        (rota-indice
         (encuentra-indice
          (char-downcase char)) (- 0 desplazamiento))
        26))))
    (else char)))
;) TEST
(descifra-caracter #\d 3) ; ⇒ #\a)
(descifra-caracter #\y -1) ; ⇒ #\z)
(descifra-caracter #\x 40) ; ⇒ #\j)
(descifra-caracter #\G 3) ; ⇒ #\D)
(descifra-caracter #\tab 3) ; ⇒ #\tab)

;)-------------------------------------------------------------------

;) EJERCICIO 3

;) V1
(define (menor-de-tres n1 n2 n3)
  (if (< n1 n2)
      (if (< n1 n3)
          n1
          n3)
      (if (< n2 n3)
          n2
          n3)))

;) TEST
(menor-de-tres 2 8 1) ;; ⇒ 1
(menor-de-tres 2 8 3) ;; ⇒ 1
(menor-de-tres 3 5 6) ;; ⇒ 1

;) V2
(define (menor x y)
  (if (< x y)
      x
      y))

(define (menor-de-tres-v2 n1 n2 n3)
  (menor (menor n1 n2) n3))

;) TEST
(menor-de-tres-v2 2 8 1) ;; ⇒ 1
(menor-de-tres-v2 2 8 3) ;; ⇒ 1
(menor-de-tres-v2 3 5 6) ;; ⇒ 1

;)-------------------------------------------------------------------

;) EJERCICIO 4

;) A
(define (f x)
    (cons x 2))

(define (g x y)
    (cons x y))

(g (f (+ 2 1)) (+ 1 1))

;) 1.- (+ 2 1) = 3
;) 2.- (f 3) = (3 . 2)
;) 3.- (+ 1 1) = 2
;) 4.- (g (3 . 2) 2) = ((3 . 2) . 2)

;) B
(define (func-1 x)
    (/ x 0))

(define (func-2 x y)
    (if (= x 0)
        0
        y))

;(func-2 0 (func-1 10))

;) Da error, si se pudiera realizar
;) se ejecutaría func-1 primero y luego func-2

;)-------------------------------------------------------------------

;) EJERCICIO 5

(define (compara-mayor string1 string2)
  (if (>= (string-length string1) (string-length string2))
      string1
      string2))

(define (añade-al-final x lista)
   (append lista (list x)))

(define (cadenas-mayores lista1 lista2)
  (define lista-resultado (list))
  (añade-al-final (compara-mayor
                   (third lista1)
                   (third lista2))
                  (añade-al-final (compara-mayor
                                   (second lista1)
                                   (second lista2))
                                  (añade-al-final (compara-mayor
                                                   (first lista1)
                                                   (first lista2)) lista-resultado))))

;) TEST
(cadenas-mayores '("hola" "que" "tal") '("meme" "y" "adios")) ; ⇒ ("hola" "que" "adios")
(cadenas-mayores '("esto" "es" "lpp") '("hoy" "hay" "clase")) ; ⇒ ("esto" "hay" "clase")

;)-------------------------------------------------------------------

;) EJERCICIO 6
(define (obten-palo char)
  (cond
    ((equal? char #\♠) 'Picas)
    ((equal? char #\♥) 'Corazones)
    ((equal? char #\♣) 'Tréboles)
    ((equal? char #\♦) 'Diamantes)
    (else "ERROR")))

(define (obten-valor char)
  (if (char-numeric? char)
      (- (char->integer char) 48)
      (cond
        ((equal? char #\J) 10)
        ((equal? char #\Q) 11)
        ((equal? char #\K) 12)
        ((equal? char #\A) 1))))

(define (separar-valor string)
  (string-ref string 0))

(define (separar-palo string)
  (string-ref string 1))

(define (carta simbolo)
  (cons (obten-valor
         (separar-valor
          (symbol->string simbolo)))
        (obten-palo
         (separar-palo
          (symbol->string simbolo)))))

;) TEST
(obten-palo #\♠)
(obten-palo #\♥)
(obten-palo #\♣)
(obten-palo #\♦)
(obten-valor #\1)
(obten-valor #\4)
(obten-valor #\J)
(obten-valor #\Q)
(obten-valor #\K)
(obten-valor #\A)
(define tres-de-picas '3♠)
(carta tres-de-picas)
(carta '5♥)

;)-------------------------------------------------------------------

;) EJERCICIO 7

(define (jugada-mano s1 s2 s3)
  (if (= (car (carta s1)) (car (carta s2)) (car (carta s3)))
      (string-append "trio de " (number->string
                                 (car
                                  (carta s1))))
      (cond
        ((= (car (carta s1)) (car (carta s3)))
            (string-append "pareja de " (number->string
                                          (car
                                           (carta s1)))))
        ((= (car(carta s1)) (car (carta s2)))
            (string-append "pareja de " (number->string
                                          (car
                                           (carta s1)))))
        ((= (car(carta s2)) (car (carta s3)))
            (string-append "pareja de " (number->string
                                          (car
                                           (carta s2)))))
        (else "nada"))))

;) TEST
(jugada-mano '3♥ '3♣ '3♥) ; ⇒ "trío de 3"
(jugada-mano 'K♦ '7♠ 'K♥) ; ⇒ "pareja de 12"
(jugada-mano '5♣ '4♣ '6♣) ; ⇒ "nada"