#lang racket
(require rackunit)

;) EJERCICIO 1

3 ;) = 3

(+ 1 2 ) ;) = 3

(+ 1 2 3 4) ;) = 10

(+) ;) = 0

(sqrt 25) ;) = 5

(* (+ 2 3) 5) ;) = 25

+ ;) = #<procedure:+>

#\+ ;) = #\+

"+" ;) = "+"

"hola" ;) = "hola"

(+ (- 4 (* 3 (/ 4 2) 4)) 3) ;) = -17

(* (+ (+ 2 3) 4) (* (* 3 3) 2)) ;) = 162

(* (+ 2 3 4 5) 3 (- 5 2 1)) ;) = 84

(+ (- (+ (- (+ 2 3) 5) 1) 2) 3) ;) = 2 

(- (sqrt (* 5 ( + 3 2))) (+ 1 1 1 1)) ;) = 1

(> (* 3 (+ 2 (+ 3 1)) (+ 1 1)) (+ (* 2 2) 3)) ;) = #t

(= (* 3 2) (+ 1 (+ 2 2) 1)) ;) = #t

(not (> (+ 3 2) 5)) ;) = #t

(and (even? 2) (odd? (+ 3 2))) ;) = #t

(remainder (+ 6 2) (+ 1 1)) ;) = 0

;)-------------------------------------------------------------------

;) EJERCICIO 2

(cons 1 2) ;) = (1 . 2)

(car (cons 1 2)) ;) = 1

(cdr (cons 1 2)) ;) = 2

(cons (* 2 3) (/ 4 2)) ;) = (6 . 2) 

(cons (+ 2 1) (if (> 2 3) "2" "3")) ;) = (3 . "3")

(car (car (cons (cons 1 2) 3))) ;) = 1

(car (cons (cons 3 4) 2)) ;) = (3 . 4)

(cdr (cons (cons 3 4) 2)) ;) = 2

(cdr (cons 1 (cons 2 3))) ;) = (2 . 3)

(cdr (car (cons (cons 1 2) 3))) ;) = 2 

;)-------------------------------------------------------------------

;) EJERCICIO 3

(list 1 2 3 4) ;) = (1 2 3 4)

(rest (list 1 2 3 4)) ;) =  (2 3 4)

(first '(1 2 3 4)) ;) = 1

(first (list #t 1 "Hola")) ;) = #t

(first (rest (list 1 2 3 4))) ;) = 2

(rest (rest '(1 2 3 4))) ;) = (3 4)

(first (rest (rest (list 1 2 3 4)))) ;) = 3

(list (* 2 2) (+ 1 2) (/ 4 2)) ;) = (4 3 2)

(list (+ 2 3) (- 3 4) (string-ref "hola" 3)) ;) = (5 -1 #\a)

(cons 3 '(1 2 3)) ;) = (3 1 2 3)

(rest (cons #t (cons "Hola" (list 1)))) ;) = ("Hola" 1)

(first (list (list 1 2) 1 2 3 4)) ;) = (1 2)

(first (rest '((1 2) 1 2))) ;) = 1

(cons '(1 2 3) '(4 5 6)) ;) = ((1 2 3) 4 5 6)

(first (rest (list 1 2 3 4))) ;) = 2

(rest (rest (list 1 2 3 4))) ;) = (3 4)

(first (rest (rest (rest '(1 2 3 4))))) ;) = 4

;)-------------------------------------------------------------------

;) EJERCICIO 4

(define l1 (list 1 2 3 4 5))
;) a)
(first (rest (rest l1)))
;) b)
(list (first (rest (rest (rest (rest l1))))))
;) c)
(first (rest (rest (rest (rest l1)))))
;) d)
(first (rest (rest (list 1 (list 2 3) (list 4 5) 6)))) ;) = (4 5)
;) e)
(rest (rest '(1 (2 3) 4 5))) ;) = (4 5)

;)-------------------------------------------------------------------

;) EJERCICIO 5

(equal? "hola" "hola") ;) = #t

(string-ref "pepe" 1) ;) = #\e

(substring "buenos dias" 1 4) ;) = "uen

;)(= "hola" "hola") ;) = Error por no ser un numero

(string-ref (substring "buenos dias" 2 5) 1) ;) = #\n

(define pi 3.14159) ;) = es una definicion: pi = 3.14159

pi ;) = 3.14159

"pi" ;) = "pi"

(+ pi (+ pi pi)) ;) = 9.42477

(+ (* pi pi) (- 2 pi pi pi pi)) ;) = -0,6967722719

(+ (char->integer(integer->char 1200)) (char->integer #\A)) ;) = 1265

(string-length (make-string 7 #\E)) ;) = 7

(define a 3)
(define b (+ a 1)) ;) b = 4 

(+ a b (* a b)) ;) = 19

(= a b) ;) = #f

(if (and (> a b) (< b (* a b))) b a) ;) = 3

(cond ((= a 4) 6)
((= b 4) (+ 6 7 a))
(else 25)) ;) = 16

(+ 2 (if (> b a) b a)) ;) = 6

(* (cond ((> a b) a)
((< a b) b)
(else -1))
(+ a 1)) ;) = 16

((if (< a b) + -) a b) ;) = 7

;)-------------------------------------------------------------------

;) EJERCICIO 6

(define (cuadrado x)
  (* x x))

(define (distancia x y)
  (sqrt (+ (cuadrado (abs (-(car x) (car y)))) (cuadrado (abs (-(cdr x) (cdr y))))))
)
;)TESTS:
(distancia (cons 0 0) (cons 0 10)) ; ⇒ 10
(distancia (cons 0 0) (cons 10 0)) ; ⇒ 10
(distancia (cons 0 0) (cons 10 10)) ; ⇒ 14.142135623730951


(define (isosceles? x y z)
  (and (or (= (distancia x y) (distancia x z)) (= (distancia x y) (distancia y z)) (= (distancia y z) (distancia x z)))
       (not (= (distancia x y) (distancia x z) (distancia y z)))
  )       
)
;)TESTS:
(isosceles? '(0 . 0) '(3 . 0) '(6 . 0)) ; ⇒ #t
(isosceles? '(2 . 2) '(4 . 0) '(0 . 0)) ; ⇒ #t
(isosceles? '(0 . 0) '(0 . 0) '(0 . 0)) ; ⇒ #f
(isosceles? '(0 . 0) '(1 . 1) '(3 . 2)) ; ⇒ #f