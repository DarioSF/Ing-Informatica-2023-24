#lang racket
(require "lpp.rkt")
(require 2htdp/image)

; EJERCICIO 1

; A)
(define (concat lista)
  (concat-iter lista ""))

(define (concat-iter lista result)
  (if (null? lista)
      result
      (concat-iter (rest lista) (string-append result (first lista)))))

; TEST
;(concat  '("hola" "y" "adiós")) ; ⇒ "holayadiós"
;(concat-iter '("hola" "y" "adiós") "") ; ⇒ "holayadiós"


; B
(define (min-max lista)
  (if (= (length lista) 1)
      (cons (first lista) (first lista))
      (min-max-iter lista '(0 . 0))))

(define (min-max-pareja dato pareja)
  (cons (min dato (car pareja))
        (max dato (cdr pareja))))

(define (min-max-iter lista pareja)
  (if (null? lista)
      pareja
      (min-max-iter (rest lista) (min-max-pareja (first lista) pareja))))

; TEST
;(min-max-iter '(7) (cons 0 0)) ; ⇒ (7 . 7)
;(min-max '(2 5 9 12 5 0 4)) ; ⇒ (0 . 12)
;(min-max '(3 2 -8 4 10 0)) ; ⇒ (-8 . 10)
;(min-max-iter '(5 9 12 -2 5 0 4) (cons 2 2)) ; ⇒ (-2 . 12)


; EJERCICIO 2

; A
(define (expande-pareja pareja)
  (expande-pareja-iter pareja '()))

(define (expande-pareja-iter pareja result)
  (cond ((null? pareja) result)
        ((= (cdr pareja) 0) result)
        (else (expande-pareja-iter (cons (car pareja)
                                         (- (cdr pareja) 1))
                                   (append result (list (car pareja))))))) 
      
(define (expande-parejas . lista-parejas)
  (expande-parejas-iter lista-parejas '()))

(define (expande-parejas-iter lista-parejas result)
  (if (null? lista-parejas)
      result
      (expande-parejas-iter (rest lista-parejas)
                            (append result (expande-pareja (first lista-parejas))))))


; TEST
;(expande-pareja (cons 'a 4)) ; ⇒ (a a a a)
;(expande-parejas '(#t . 3) '("LPP" . 2) '(b . 4)) ; ⇒ (#t #t #t "LPP" "LPP" b b b b)


; B
(define (rotar k lista)
  (cond ((= k 0) lista)
        ((null? lista) '())
        (else (rotar (- k 1) (append (rest lista) (list (first lista))))))) 


; TEST
;(rotar 4 '(a b c d e f g)) ; ⇒ (e f g a b c d)


; EJERCICIO 3

; A
(define (mi-foldl funcion result lista)
  (if (null? lista)
      result
      (mi-foldl funcion (funcion (first lista) result) (rest lista))))


; TEST
;(mi-foldl string-append "****" '("hola" "que" "tal")) ; ⇒ "talquehola****"
;(mi-foldl cons '() '(1 2 3 4)) ; ⇒ (4 3 2 1)


; B
(define (binario-a-decimal lista-bits)
  (binario-a-decimal-iter 0 lista-bits))

(define (binario-a-decimal-iter result lista-bits)
  (if (null? lista-bits)
      result
      (binario-a-decimal-iter (+ (* result 2) (first lista-bits)) (rest lista-bits)))) 


; TEST
;(binario-a-decimal '(1 1 1 1)) ; ⇒ 15
;(binario-a-decimal '(1 1 0)) ; ⇒ 6
;(binario-a-decimal '(1 0)) ; ⇒ 2


; EJERCICIO 4

(define (pascal-memo row col dic)
  (cond ((= col 0) 1)
        ((= row col) 1)
        ((not (equal? (get (cons row col) dic) #f)) (get (cons row col) dic))
        (else (put (cons row col) (+ (pascal-memo (- row 1) (- col 1) dic)
                                    (pascal-memo (- row 1) col dic)) dic))))

; TEST
;(define diccionario (crea-diccionario))
;(pascal-memo 8 4 diccionario) ; ⇒ 70
;(pascal-memo 40 20 diccionario) ; ⇒ 137846528820


; EJERCICIO 5

; A

(define (koch nivel trazo)
  (if (= nivel 0)
      (line trazo 0 "pink")
      (dibuja-koch (koch (- nivel 1) (/ trazo 3))))) 

(define (dibuja-koch curva)
  (beside/align "bottom"
                curva
                (rotate 60 curva)
                (rotate -60 curva)
                curva))

; TEST
;(koch 5 600)


; B

(define (copo-nieve nivel trazo)
  (dibuja-copo (koch nivel trazo)))

(define (dibuja-copo figura)
  (above figura
         (beside (rotate 120 figura)
                 (rotate -129 figura))))
  

; TEST
;(copo-nieve 3 200)


; EJERCICIO 6

(define (alfombra-sierpinski tam)
  (if (<= tam 20)
      (circle (/ tam 2) "outline" "pink")
      (dibuja-alfombra (alfombra-sierpinski (/ tam 3))
                       (circle (/ tam 6) "solid" "pink"))))

(define (dibuja-alfombra figura circulo)
  (above (beside figura figura figura)
         (beside figura circulo figura)
         (beside figura figura figura)))
  

; TEST
;(alfombra-sierpinski 360)