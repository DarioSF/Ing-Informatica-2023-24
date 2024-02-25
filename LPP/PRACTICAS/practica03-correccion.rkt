#lang racket
(require rackunit)
(require "lpp.rkt")

;--------------;
; Ejercicio 1: ;
;--------------;

;------;
; a.1) ;
;------;

(define (menor a b)
  (if (< a b) a b))

(define (minimo lista)
  (if (null? (rest lista))
      (first lista)
      (menor (first lista) (minimo (rest lista)))))

(check-equal? (minimo '(1 8 6 4 3)) 1)
(check-equal? (minimo '(1 -1 3 -6 4)) -6)

;------;
; a.2) ;
;------;
; ¿Qué lista se pasa como parámetro a la primera llamada recursiva a la función?
; (8 6 4 3)
; ¿Qué devuelve esa llamada recursiva?
; 3
; ¿Con qué argumentos se llama a la función menor que devuelve el resultado final?
; (menor 1 3)

;----;
; b) ;
;----;

(define (concatena lista-chars)
  (if (null? lista-chars)
      ""
      (string-append (string (first lista-chars))
                     (concatena (rest lista-chars)))))

(check-equal? (concatena '()) "")
(check-equal? (concatena '(#\H #\o #\l #\a)) "Hola")
(check-equal? (concatena '(#\S #\c #\h #\e #\m #\e #\space #\m #\o #\l #\a)) "Scheme mola")

;----;
; c) ;
;----;

;;; Práctica anterior --------------------------

(define indice-char-a (char->integer #\a))
(define indice-char-z (char->integer #\z))
(define tamaño-alfabeto (+ (- indice-char-z indice-char-a) 1))

(define (encuentra-indice char)
  (- (char->integer char)
     indice-char-a))

(define (encuentra-caracter indice)
  (integer->char (+ indice indice-char-a)))

(define (entre-az? char)
  (and (char>=? char #\a) (char<=? char #\z)))

(define (rota-indice indice desplazamiento)
  (modulo (+ indice desplazamiento) tamaño-alfabeto))
  
(define (cifra-caracter-minuscula char desplazamiento)
  (if (not (entre-az? char))
      char
      (encuentra-caracter (rota-indice (encuentra-indice char) desplazamiento))))

(define (cifra-caracter char desplazamiento)
  (if (char-upper-case? char)
      (char-upcase (cifra-caracter-minuscula (char-downcase char) desplazamiento))
      (cifra-caracter-minuscula char desplazamiento)))

(define (descifra-caracter char desplazamiento)
  (cifra-caracter char (- desplazamiento)))

;; Solución 1c) ---------------------------------------------

(define (resto-cadena cad)
  (substring cad 1 (string-length cad)))

(define (primero-cadena cad)
  (string-ref cad 0))

(define (cifra-cadena cad desplazamiento)
  (if (equal? cad "")
      ""
      (string-append (string (cifra-caracter (primero-cadena cad) desplazamiento))
                     (cifra-cadena (resto-cadena cad) desplazamiento))))

(define (descifra-cadena cad desplazamiento)
  (cifra-cadena cad (- desplazamiento)))

(check-equal? (cifra-cadena "En un lugar de la Mancha, de cuyo nombre no quiero acordarme" 10)
              "Ox ex veqkb no vk Wkxmrk, no meiy xywlbo xy aesoby kmybnkbwo")
(check-equal? (descifra-cadena "Ox ex veqkb no vk Wkxmrk, no meiy xywlbo xy aesoby kmybnkbwo" 10)
              "En un lugar de la Mancha, de cuyo nombre no quiero acordarme")

;----;
; d) ;
;----;


(define (contiene? lista elemento)
  (and (not (null? lista))
       (or (equal? elemento
                   (first lista))
           (contiene? (rest lista) elemento))))

(check-false (contiene? '() 'algo))
(check-true (contiene? '(algo 3 #\A) 3) )
(check-true (contiene? '(algo 3 #\A) 'algo))
(check-false (contiene? '(algo 3 #\A) "A"))

(define (str-contiene? cadena char)
  (contiene? (string->list cadena) char))

(check-true (str-contiene? "Hola" #\o))
(check-true (str-contiene? "Esto es una frase" #\space))
(check-false (str-contiene? "Hola" #\h))

;--------------;
; Ejercicio 2: ;
;--------------;

;----;
; a) ;
;----;

(define (todos-iguales? lista)
  (or (null? lista)
      (null? (rest lista))
      (and (equal? (first lista)
                   (second lista))
           (todos-iguales? (rest lista)))))

(check-true (todos-iguales? '()))
(check-true (todos-iguales? '(a)))
(check-true (todos-iguales? '(a a a a a a a)))
(check-true (todos-iguales? '((a b) (a b) (a b))))
(check-false (todos-iguales? '(a a a a a b)))

;----;
; b) ;
;----;

(define (todos-distintos? lista)
  (or (null? lista)
      (and (not (contiene? (rest lista) (first lista)))
           (todos-distintos? (rest lista)))))

(check-true (todos-distintos? '(A B C)))
(check-true (todos-distintos? '(A B)))
(check-true (todos-distintos? '(A)))
(check-true (todos-distintos? '()))
(check-false (todos-distintos? '(A B A)))
(check-false (todos-distintos? '(A B A)))
(check-false (todos-distintos? '(A B B)))

;----;
; c) ;
;----;

(define (solo-dos-iguales? lista)
  (cond ((null? lista) #f)
        ((contiene? (rest lista) (first lista))
         (todos-distintos? (rest lista)))
        (else
         (solo-dos-iguales? (rest lista)))))

(check-false (solo-dos-iguales? '()))
(check-false (solo-dos-iguales? '(1)))
(check-false (solo-dos-iguales? '(1 2)))
(check-true (solo-dos-iguales? '(2 2)))
(check-false (solo-dos-iguales? '(1 2 3)))
(check-true (solo-dos-iguales? '(1 2 1)))
(check-false (solo-dos-iguales? '(2 2 2)))
(check-false (solo-dos-iguales? '(1 2 3 4)))
(check-true (solo-dos-iguales? '(1 2 1 3)))
(check-false (solo-dos-iguales? '(1 2 1 2)))

;--------------;
; Ejercicio 3: ;
;--------------;

;------;
; a.1) ;
;------;

(define p1 (list (cons 'a 'b) 'c (list 'd 'e)))

(check-equal? p1 '((a . b) . (c . ((d . (e . ())) . ()))))

(caja-puntero p1)

;------;
; a.2) ;
;------;

(check-equal? (cdr (first p1)) 'b)

(check-equal? (first (third p1)) 'd)

;------;
; b.1) ;
;------;

(define p2 (list (list (cons 'a (cons 'b 'c)) (list 'd 'e) 'f) 'g))

(check-equal? p2 '(((a . (b . c)) . ((d . (e . ())) . (f . ()))) . (g . ())))

(caja-puntero p2)

;------;
; b.2) ;
;------;

(check-equal? (cdr (cdr (first (first p2)))) 'c)

(check-equal? (second (second (first p2))) 'e)

;--------------;
; Ejercicio 4: ;
;--------------;

(define (datos-iguales? pareja)
  (equal? (car pareja) (cdr pareja)))


(define (contar-datos-iguales lista-parejas)
  (if (null? lista-parejas)
      0
      (+ (if (datos-iguales? (first lista-parejas))
             1
             0)
         (contar-datos-iguales (rest lista-parejas)))))

;
; Las siguientes versiones también son correctas:
;
; Versión 1:
;
;
;(define (suma-uno-si-datos-iguales pareja valor)
;  (if (datos-iguales? pareja)
;      (+ 1 valor)
;      valor))
;
;(define (contar-datos-iguales lista-parejas)
;  (if (null? lista-parejas)
;      0
;      (suma-uno-si-datos-iguales (first lista-parejas)
;                                 (contar-datos-iguales (rest lista-parejas)))))
;
; Versión 2:
;
;(define (contar-datos-iguales lista-parejas)
;  (cond
;    ((null? lista-parejas) 0)
;    ((datos-iguales? (first lista-parejas))
;     (+ 1 (contar-datos-iguales (rest lista-parejas))))
;    (else (contar-datos-iguales (rest lista-parejas)))))


(check-true (datos-iguales? '(a . a)))
(check-false (datos-iguales? '(#\A . #\B)))
(check-equal? (contar-datos-iguales '((2 . 3) ("hola" . "hola") (\#a . \#a) (true . false)))
              2)
(check-equal? (contar-datos-iguales '((2 . "hola") ("hola" . 3) (\#a . true) (\#b . false)))
              0)

;--------------;
; Ejercicio 5: ;
;--------------;

;----;
; a) ;
;----;

(define (obten-palo caracter)
  (cond
    ((equal? #\♠ caracter) 'Picas)
    ((equal? #\♣ caracter) 'Tréboles)
    ((equal? #\♥ caracter) 'Corazones)
    (else 'Diamantes)))

(define (obten-valor caracter)
  (cond
    ((equal? #\A caracter) 1)  ; As
    ((equal? #\J caracter) 10) ; Sota
    ((equal? #\Q caracter) 11) ; Caballo
    ((equal? #\K caracter) 12) ; Rey
    (else (- (char->integer caracter) (char->integer #\0)))))

(define (carta simbolo)
  (cons (obten-valor (string-ref (symbol->string simbolo) 0))
        (obten-palo (string-ref (symbol->string simbolo) 1))))

(define (valor-carta c)
  (car (carta c)))

(define (palo-carta c)
  (cdr (carta c)))

;----;
; b) ;
;----;


(define (veces-palo lista palo)
  (if (null? lista)
      0
      (+ (if (equal? (palo-carta (first lista)) palo)
             1
             0)
         (veces-palo (rest lista) palo))))

(check-equal? (veces-palo '(5♠ 6♣ 7♥ 8♦ 9♠) 'Picas) 2)
(check-equal? (veces-palo '(J♠ Q♣ K♥) 'Diamantes) 0)
(check-equal? (veces-palo '(A♣ 2♥ 3♠) 'Corazones) 1)
(check-equal? (veces-palo '() 'Tréboles) 0)

(define (color? mano)
  (= (veces-palo mano (palo-carta (first mano))) 5))


(define mano1 '(5♣ J♦ J♣ Q♠ Q♥))
(define mano2 '(2♦ 5♦ 6♦ J♦ K♦))
(define mano3 '(A♦ 2♦ 3♣ 4♦ 5♥))
(define mano4 '(8♥ 9♥ J♥ Q♥ K♥))

(check-false (color? mano1))
(check-true (color? mano2))
(check-false (color? mano3))
(check-true (color? mano4))

;----;
; c) ;
;----;

(define (escalera? mano)
  (or (null? (rest mano))
      (and (= (+ 1 (valor-carta (first mano))) (valor-carta (second mano)))
           (escalera? (rest mano)))))

(check-false (escalera? mano1))
(check-false (escalera? mano2))
(check-true (escalera? mano3))
(check-true (escalera? mano4))

(define (escalera-de-color? mano)
  (and (color? mano)
       (escalera? mano)))

(check-false (escalera-de-color? mano1))
(check-false (escalera-de-color? mano2))
(check-false (escalera-de-color? mano3))
(check-true (escalera-de-color? mano4))

;--------------;
; Ejercicio 6: ;
;--------------;

;----;
; a) ;
;----;

(define (suma-izq pareja n)
  (cons (+ (car pareja) n)
        (cdr pareja)))

(define (suma-der pareja n)
  (cons (car pareja)
        (+ (cdr pareja) n)))

(check-equal? (suma-izq (cons 10 20) 3) '(13 . 20))
(check-equal? (suma-der (cons 10 20) 5) '(10 . 25))

;----;
; b) ;
;----;

(define (suma-impares-pares lista-num)
  (cond
    ((null? lista-num)
     (cons 0 0))
    ((even? (first lista-num))
     (suma-der (suma-impares-pares (rest lista-num)) (first lista-num)))
    (else
     (suma-izq (suma-impares-pares (rest lista-num)) (first lista-num)))))

(check-equal? (suma-impares-pares '(3 2 1 4 8 7 6 5)) '(16 . 20))
(check-equal? (suma-impares-pares '(3 1 5)) '(9 . 0))

;---------------------------------------------------------------
; A continuación planteamos una solución mejorada que
; elimina la duplicidad de la llamada recursiva y lleva la
; lógica de la función a una función auxiliar. Esta sería una solución
; más elegante y correcta desde el punto de vista funcional.
;---------------------------------------------------------------

(define (suma-impar-par pareja n)
  (if (even? n)
     (suma-der pareja n)
     (suma-izq pareja n)))

(define (suma-impares-pares-mejorada lista-num)
  (if (null? lista-num)
      (cons 0 0)
      (suma-impar-par (suma-impares-pares-mejorada (rest lista-num)) (first lista-num))))


(check-equal? (suma-impares-pares-mejorada '(3 2 1 4 8 7 6 5)) '(16 . 20))
(check-equal? (suma-impares-pares-mejorada '(3 1 5)) '(9 . 0))



;----;
; c) ;
;----;

(define (mejor-cadena pareja cadena)
  (if (> (string-length cadena)
         (cdr pareja))
      (cons cadena (string-length cadena))
      pareja))

(define (cadena-mayor lista)
  (if (null? lista)
      (cons "" 0)
      (mejor-cadena (cadena-mayor (rest lista)) (first lista))))

(check-equal? (cadena-mayor '("vamos" "a" "obtener" "la" "cadena" "mayor")) '("obtener" . 7))
(check-equal? (cadena-mayor '("prueba" "con" "maximo" "igual")) '("maximo" . 6))
(check-equal? (cadena-mayor '()) '("" . 0))