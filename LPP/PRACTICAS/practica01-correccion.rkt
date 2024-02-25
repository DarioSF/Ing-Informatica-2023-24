#lang racket
(require rackunit)


;--------------;
; Ejercicio 6: ;
;--------------;

;;
;; Apartado a
;;

(define (cuadrado x)
  (* x x))

(define (distancia-x p1 p2)
  (- (car p2) (car p1)))

(define (distancia-y p1 p2)
  (- (cdr p2) (cdr p1)))

(define (distancia p1 p2)
  (sqrt (+ (cuadrado (distancia-x p1 p2))
           (cuadrado (distancia-y p1 p2)))))
 
;; Pruebas unitarias

(check-equal? (cuadrado 10) 100)
(check-equal? (cuadrado -4) 16)

(check-equal? (distancia-x '(2 . 8) '(10 . 4)) 8)
(check-equal? (distancia-y '(2 . 8) '(10 . 4)) -4)

(check-equal? (distancia '(0 . 0) '(0 . 10)) 10)
(check-equal? (distancia '(0 . 0) '(10 . 0)) 10)
(check-equal? (distancia '(3 . 8) '(6 . 4)) 5)
(check-equal? (distancia '(0 . 0) '(10 . 10)) 14.142135623730951)

;;
;; Apartado b
;;

; La función solo-dos-iguales? recibe tres números y comprueba
; que solo dos de ellos son iguales.

(define (solo-dos-iguales? d1 d2 d3)
  (and (not (= d1 d2 d3))
       (or (= d1 d2) (= d1 d3) (= d2 d3))))


; Un triángulo es isósceles cuando solo tiene dos lados iguales. 
; Llamamos a la función anterior pasándole como parámetro las distancias
; de cada uno de los lados.

(define (isosceles? p1 p2 p3)
  (solo-dos-iguales? (distancia p1 p2)
                     (distancia p2 p3)
                     (distancia p3 p1)))

; La siguiente función también es correcta, pero no es tan elegante,
; abstracta y concisa como la función anterior, porque no usa 
; composición de funciones y no usa el concepto de `solo-dos-iguales?`,
; repitiéndose muchas llamadas a la función `distancia` con los mismos
; parámetros.

;(define (isosceles? p1 p2 p3)
;  (and (not (= (distancia p1 p2) (distancia p2 p3) (distancia p3 p1)))
;       (or (= (distancia p1 p2) (distancia p2 p3))
;           (= (distancia p1 p2) (distancia p2 p3))
;           (= (distancia p2 p3) (distancia p3 p1)))))


;; Pruebas unitarias

(check-false (solo-dos-iguales? 1 2 3))
(check-true (solo-dos-iguales? 1 2 1))
(check-false (solo-dos-iguales? 2 2 2))
       
(check-true (isosceles? '(0 . 0) '(3 . 0) '(6 . 0)))
(check-true (isosceles? '(0 . 0) '(2 . 2) '(4 . 0)))
(check-false (isosceles? '(0 . 0) '(0 . 0) '(0 . 0)))