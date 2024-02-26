#lang racket
(require rackunit)
(require "lpp.rkt")

; EJERCICIO 1

; a)

(define (aplica-veces f1 f2 n x)
  (if (= n 0)
      x
      (f1 (f2 (aplica-veces f1 f2 (- n 1) x)))))

; TEST
(aplica-veces (lambda (x) (+ x 1)) (lambda (x) (+ x 2)) 2 10) ; ⇒ 16
(aplica-veces (lambda (x) (* x x)) (lambda (x) (+ x 1)) 4 3) ; ⇒ 7072978201

; b)

(define (inserta-segundo-cond pred dato lista)
  (if (pred (first lista))
      (cons (first lista)
            (cons dato (rest lista)))
      (cons dato lista)))

(define (mueve-al-principio-condicion pred lista)
  (cond ((= (length lista) 1) lista)
      ((pred (first lista)) lista)
      (else (inserta-segundo-cond pred (first lista) (mueve-al-principio-condicion pred (rest lista))))))

; TEST
(mueve-al-principio-condicion number? '(a b c 1 d 1 e)) ; ⇒ (1 a b c d 1 e)
(mueve-al-principio-condicion number? '(1 a b 1 c)) ; ⇒ (1 a b 1 c)
(mueve-al-principio-condicion number? '(a b c d)) ; ⇒ '(a b c d)

; c)

(define (comprueba-simbolos lista-simbolos lista-num)
  (cond
    ((or (null? lista-simbolos) (null? lista-num)) '())
    ((= (string-length (symbol->string (first lista-simbolos)))
        (first lista-num))
     (cons (cons (first lista-simbolos)
                 (first lista-num))
           (comprueba-simbolos (rest lista-simbolos)
                            (rest lista-num))))
    (else (comprueba-simbolos (rest lista-simbolos)
                           (rest lista-num))))) ;TERMINAR

; TEST
(comprueba (lambda (x y)
             (= (string-length (symbol->string x)) y))
           '(este es un ejercicio de examen) 
           '(2 1 2 9 1 6))
; ⇒ ((un . 2) (ejercicio . 9) (examen . 6))

(comprueba (lambda (x y)
              (= (string-length x) (string-length y)))
             '("aui" "a" "ae" "c" "aeiou")
             '("hola" "b" "es" "que" "cinco"))
; ⇒ (("a" . "b") ("ae" . "es") ("aeiou" . "cinco"))



;(define t1 (reordena-tres-montones (cartas 48) first second third))
;(define t2 (reordena-cuatro-montones (junta-montones t1) first third second fourth))
;(define t3 (reordena-cuatro-montones (junta-montones t2) fourth second first third))
;(adivina (junta-montones t3) '(2 . 3) '(4 . 4) '(4 . 4)) ; da la carta que habia pensado
