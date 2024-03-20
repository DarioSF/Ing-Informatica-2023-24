#lang racket
(require rackunit)
(require "lpp.rkt")

; EJERCICIO 1
; A)
(define lista-a '((a b) d (c (e) (f g) h)))
(check-equal? (fourth (third lista-a)) 'h)