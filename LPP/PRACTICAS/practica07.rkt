#lang racket
(require rackunit)
(require "lpp.rkt")

; EJERCICIO 1

; A)

(define lista-a '((a b) d (c (e) (f g) h)))

; TEST
(check-equal? (fourth (third lista-a)) 'h)

; B

(define lista-b1 '((2 (3)) (4 2) ((2) 3)))
;        *
;   /    |     \
;  *     *      *
; / \   / \    / \
; 2  * 4   2  *   3
;    |        |
;    3        2

; TEST
;(pinta-lista lista-b1)

(define lista-b2 '((b) (c (a)) d (a)))
;            *
;   /     /     \    \
;  *     *       d    *
;  |    / \           |
;  b   c   *          a
;          |
;          a

; TEST
;(pinta-lista lista-b2)

; C

(define (cuadrado-estruct lista)
  (cond ((null? lista) '())
        ((hoja? lista) (* lista lista ))
        (else (cons
             (cuadrado-estruct (first lista)) ; -> 1
             (cuadrado-estruct (rest lista)))))) ; -> 2

; 1) ((4 (9)) (16 4) ((4) 9))
; 2) 1 -> (cuadrado-estruct (2 (3)))
;    2 -> (cuadrado-estruct ((4 2) ((2) 3)))
; 3) 1 -> (4 (9))
;    2 -> ((16 4) ((4) 9))

; D

; (-1 2 -1 1)


; EJERCICIO 2

; A

(define (concatena lista)
  (cond ((null? lista) "")
        ((hoja? lista) (symbol->string lista))
        (else (string-append (concatena (first lista))
                             (concatena (rest lista))))))

(define (concatena-fos lista)
  (if (hoja? lista)
      (symbol->string lista)
      (apply string-append (map concatena-fos lista))))


; TEST
;(concatena '(a b (c) d)) ; ⇒ "abcd"
;(concatena-fos '(a (((b)) (c (d (e f (g))) h)) i)) ; ⇒ "abcdefghi"

; B1

(define (todos-positivos? lista)
  (cond ((null? lista) #t)
        ((hoja? lista) (positive? lista))
        (else (and (todos-positivos? (first lista))
                   (todos-positivos? (rest lista))))))

; B2
(define (todos-positivos-fos? lista)
  (if (hoja? lista)
      (positive? lista)
      (for-all? todos-positivos-fos? lista)))

; TEST
;(todos-positivos? '(1 (2 (3 (-3))) 4)) ; ⇒ #f
;(todos-positivos? '(2 (4 (2)))) ; ⇒ #t
;(todos-positivos-fos? '(1 (2 (3 (3))) 4)) ; ⇒ #t
;(todos-positivos-fos? '(2 (4 (-2)))) ; ⇒ #f


; EJERCICIO 3

; RECURSIVA PURA

(define (cumplen-predicado pred lista)
  (cond ((null? lista) '())
        ((hoja? lista)
         (if (pred lista)
             (list lista)
             '()))
        (else (append (cumplen-predicado pred (first lista))
                      (cumplen-predicado pred (rest lista))))))

; FOS

(define (cumplen-predicado-fos pred lista)
  (if (hoja? lista)
      (if (pred lista)
          (list lista)
          '())
      (foldr append '() (map (lambda (elem)
                               (cumplen-predicado-fos pred elem)) lista))))

; TEST
;(cumplen-predicado even? '(1 (2 (3 (4))) (5 6))) ; ⇒ (2 4 6)
;(cumplen-predicado pair? '(((1 . 2) 3 (4 . 3) 5) 6)) ; ⇒ ((1 . 2) (4 . 3))
;(cumplen-predicado-fos even? '(1 (2 (3 (4))) (5 6))) ; ⇒ (2 4 6)
;(cumplen-predicado-fos pair? '(((1 . 2) 3 (4 . 3) 5) 6)) ; ⇒ ((1 . 2) (4 . 3))


(define (busca-mayores n lista-num)
  (cumplen-predicado (lambda (elem)
                       (> elem n))
                     lista-num))


; TEST
;(busca-mayores 10 '(-1 (20 (10 12) (30 (25 (15)))))) ; ⇒ (20 12 30 25 15)


(define (empieza-por char lista-pal)
  (cumplen-predicado (lambda (elem)
                       (equal? char (string-ref (symbol->string elem) 0)))
                     lista-pal))
  

; TEST
;(empieza-por #\m '((hace (mucho tiempo)) (en) (una galaxia ((muy  muy) lejana)))); ⇒ (mucho muy muy)


; EJERCICIO 4

; A1

(define (sustituye-elem elem-old elem-new lista)
  (cond ((null? lista) '())
        ((hoja? lista) (if (equal? elem-old lista)
                           elem-new
                           lista))
        (else (cons (sustituye-elem elem-old elem-new (first lista))
                    (sustituye-elem elem-old elem-new (rest lista))))))

; A2

(define (sustituye-elem-fos elem-old elem-new lista)
  (if (hoja? lista)
      (if (equal? elem-old lista)
          elem-new
          lista)
      (map (lambda (sublista)
             (sustituye-elem-fos elem-old elem-new sublista)) lista)))
; TEST
;(sustituye-elem 'c 'h '(a b (c d (e c)) c (f (c) g))) ; ⇒ (a b (h d (e h)) h (f (h) g))
;(sustituye-elem-fos 'c 'h '(a b (c d (e c)) c (f (c) g))) ; ⇒ (a b (h d (e h)) h (f (h) g))

; B

(define lista-1 '(a (b c) (d)))
(define lista-2 '((e) (f) (g)))

(define (enlaza lista1 lista2)
 (if (null? lista1)
     lista2
     (cons lista1 lista2)))

(define (intersecta lista-1 lista-2)
  (cond ((or (null? lista-1) (null? lista-2)) '())
        ((and (hoja? lista-1) (hoja? lista-2)) (cons lista-1 lista-2))
        ((and (list? lista-1) (list? lista-2))
         (enlaza (intersecta (first lista-1) (first lista-2))
                 (intersecta (rest lista-1) (rest lista-2))))
        (else '())))

; TEST
(intersecta lista-1 lista-2) ; ⇒ (((b . f)) ((d . g)))

      

