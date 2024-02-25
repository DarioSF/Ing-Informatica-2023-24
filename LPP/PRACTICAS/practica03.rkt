#lang racket
(require rackunit)
(require "lpp.rkt")

;) EJERCICIO 1
;) A)

(define (minimo lista)
  (if (null? (rest lista))
      (first lista)
      (min (minimo (rest lista)) (first lista))))

;) TEST

(minimo '(2)) ; ⇒ 2
(minimo '(1 8 6 4 3)) ; ⇒ 1
(minimo '(1 -1 3 -6 4)) ; ⇒ -6

;) B)

(define (concatena lista-char)
  (if (null? lista-char)
      ""
      (string-append (string (first lista-char)) (concatena (rest lista-char)))))

;) TEST

(concatena '()) ; ⇒ ""
(concatena '(#\H #\o #\l #\a)) ; ⇒ "Hola"
(concatena '(#\S #\c #\h #\e #\m #\e #\space #\m #\o #\l #\a)) ; ⇒ "Scheme mola"

;) C)

;) ENCONTRAR INDICE 
(define (encuentra-indice char)
  (- (char->integer char) (char->integer #\a)))

;) ENCONTRAR CARACTER
(define (encuentra-caracter indice)
  (integer->char
   (+ indice (char->integer #\a))))

;) ESTA ENTRE a Y z
(define (entre-az? char)
  (and (char>=? char #\a)(char<=? char #\z)))

;) ESTA ENTRE A Y Z
(define (entre-mayus-az? char)
  (and (char>=? char #\A)(char<=? char #\Z)))

;) ROTAR EL CARACTER
(define (rota-indice indice desplazamiento)
  (if(< 0 (+ indice desplazamiento))
        (- (+ indice desplazamiento) 26)
        (+ indice desplazamiento 26)))

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

;) INTERCAMBIADOR STRING-LISTA-STRING
(define (intercambiador-str-list cadena)
  (list->string (rest (string->list cadena))))

;) FUNCION FINAL CIFRADO
(define (cifra-cadena cad desplazamiento)
  (if (= (string-length cad) 0)
  ""
  (string-append (string (cifra-caracter  (string-ref cad 0) desplazamiento)) (cifra-cadena (intercambiador-str-list cad) desplazamiento))))

;) FUNCION FINAL DESCIFRAR
(define (descifra-cadena cad desplazamiento)
  (if (= (string-length cad) 0)
  ""
  (string-append (string (descifra-caracter  (string-ref cad 0) desplazamiento)) (descifra-cadena (intercambiador-str-list cad) desplazamiento))))

;) TEST
(cifra-cadena "En un lugar de la Mancha, de cuyo nombre no quiero acordarme" 10) ; ⇒ "Ox ex veqkb no vk Wkxmrk, no meiy xywlbo xy aesoby kmybnkbwo"
(descifra-cadena "Ox ex veqkb no vk Wkxmrk, no meiy xywlbo xy aesoby kmybnkbwo" 10) ; ⇒ "En un lugar de la Mancha, de cuyo nombre no quiero acordarme"

;) D)
;(define (contiene? lista elemento))

;) TEST
;(contiene? '(algo 3 #\A) 3) ; ⇒ #t
;(contiene? '(algo 3 #\A) "algo") ; ⇒ #f
;(contiene? '(algo 3 #\A) 'algo) ; ⇒ #t
;(str-contiene? "Hola" #\o) ; ⇒ #t
;(str-contiene? "Esto es una frase" #\space) ; ⇒ #t
;(str-contiene? "Hola" #\h) ; ⇒ #f

;) EJERCICIO 2
;) A)
(define (todos-iguales? lista)
  (cond
    ((null? lista) #t)
    ((equal? (first lista) (last lista)) (todos-iguales? (rest lista)))
    (else #f)))

;) TEST
(todos-iguales? '()) ; ⇒ #t
(todos-iguales? '(a)) ; ⇒ #t
(todos-iguales? '(a a a a a a a)) ; ⇒ #t
(todos-iguales? '((a b) (a b) (a b))) ; ⇒ #t
(todos-iguales? '(a a a a a b)) ; ⇒ #f
"b)"
;) B)
(define (todos-distintos? lista)
  (cond
    ((null? lista) #t)
    ((= (length lista) 1) #t)
    ((not (equal? (first lista) (last lista))) (todos-distintos? (rest lista)))
    (else #f)))

;) TEST
(todos-distintos? '()) ; ⇒ #t
(todos-distintos? '(a)) ; ⇒ #t
(todos-distintos? '(a b c)) ; ⇒ #t
(todos-distintos? '(a b c a)) ; ⇒ #f
"c)"
;) C)
(define (solo-dos-iguales? lista)
  (cond
    ((= (length lista) 1) #f)
    ((or (todos-distintos? lista) (todos-iguales? lista)) #f)
    ((not (equal? (first lista) (last lista))) (todos-distintos? (rest lista)))
    (else #f)))

;) TEST
(solo-dos-iguales? '()) ; ⇒ #f
(solo-dos-iguales? '(a)) ; ⇒ #f
(solo-dos-iguales? '(a b c a)) ; ⇒ #t
(solo-dos-iguales? '(a b c b a a)) ; ⇒ #f
(solo-dos-iguales? '(a b c a a)) ; ⇒ #f

