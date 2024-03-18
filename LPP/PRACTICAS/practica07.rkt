#lang racket
(require rackunit)
(require "lpp.rkt")

(define lista-a '((a b) d (c (e) (f g) h)))
(check-equal? (fourth (third lista-a)) 'h)