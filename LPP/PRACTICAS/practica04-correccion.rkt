#lang racket
(require rackunit)
(require "lpp.rkt")

;--------------;
; Ejercicio 1: ;
;--------------;

;----;
; a) ;
;----;

(define (es-prefijo? pal1 pal2)
  (and (<= (string-length pal1) (string-length pal2))
       (equal? pal1 (substring pal2 0 (string-length pal1)))))

(check-true (es-prefijo? "" "algo"))
(check-true (es-prefijo? "ante" "anterior"))
(check-false (es-prefijo? "antena" "anterior"))
(check-false (es-prefijo? "antena" "ante"))

(define (contiene-prefijo prefijo lista-pal)
  (if (null? lista-pal)
      '()
      (cons (es-prefijo? prefijo (first lista-pal))
            (contiene-prefijo prefijo (rest lista-pal)))))

(check-equal? (contiene-prefijo "ante" '("anterior" "antígona" "antena" "anatema"))
              '(#t #f #t #f))


;----;
; b) ;
;----;

(define (mayor-cadena cadena1 cadena2)
  (if (< (string-length cadena1)
         (string-length cadena2))
      cadena2
      cadena1))

(define (cadenas-mayores lista1 lista2)
  (cond
    ((null? lista1) lista2)
    ((null? lista2) lista1)
    (else
     (cons (mayor-cadena (first lista1) (first lista2))
           (cadenas-mayores (rest lista1) (rest lista2))))))


;; Pruebas unitarias
(check-equal? (cadenas-mayores '("hola" "que" "tal") '("adios"))
              '("adios" "que" "tal"))
(check-equal? (cadenas-mayores '("hola" "que" "tal") '("meme" "y" "adios"))
              '("hola" "que" "adios"))
(check-equal? (cadenas-mayores '("la" "primera" "práctica" "de" "recursión")
                               '("confiar" "en" "la" "recursión" "facilita" "su" "resolución"))
              '("confiar" "primera" "práctica" "recursión" "recursión" "su" "resolución"))


;--------------;
; Ejercicio 2: ;
;--------------;


;----;
; a) ;
;----;

(define (inserta-pos dato pos lista)
  (if (= pos 0)
      (cons dato lista)
      (cons (first lista)
            (inserta-pos dato (- pos 1) (rest lista)))))

(check-equal? (inserta-pos 'b 2 '(a a a a)) '(a a b a a))
(check-equal? (inserta-pos 'b 0 '(a a a a)) '(b a a a a))
(check-equal? (inserta-pos 'b 4 '(a a a a)) '(a a a a b))



;----;
; b) ;
;----;

(define (inserta-ordenada n lista-ordenada)
  (cond
    ((null? lista-ordenada) (list n))
    ((<= n (first lista-ordenada)) (cons n lista-ordenada))
    (else (cons (first lista-ordenada)
                (inserta-ordenada n (rest lista-ordenada))))))

(check-equal? (inserta-ordenada 10 '(-8 2 3 11 20)) '(-8 2 3 10 11 20))

;----;
; c) ;
;----;


(define (ordena lista)
  (if (null? lista)
      '()
      (inserta-ordenada (first lista) (ordena (rest lista)))))

(check-equal? (ordena '(2 -1 100 4 -6)) '(-6 -1 2 4 100))

;--------------;
; Ejercicio 3: ;
;--------------;

;----;
; a) ;
;----;

(define (mueve-al-principio lista dato)
  (if (equal? (first lista) dato)
      lista
      (inserta-en-segunda-posicion (first lista) (mueve-al-principio (rest lista) dato))))

(define (inserta-en-segunda-posicion dato lista)
  (cons (first lista)
        (cons dato (rest lista))))

(check-equal? (mueve-al-principio '(a b c d e f e e g) 'e) '(e a b c d f e e g))
(check-equal? (mueve-al-principio '(a b c d e f g) 'a) '(a b c d e f g))

;----;
; b) ;
;----;

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
                           (rest lista-num)))))

(check-equal? (comprueba-simbolos '(este es un ejercicio de examen) '(2 1 2 9 1 6))
              '((un . 2) (ejercicio . 9) (examen . 6)))

;--------------;
; Ejercicio 4: ;
;--------------;

;----;
; a) ;
;----;

(define (expande-pareja pareja)
  (if (= (cdr pareja) 0)
      '()
      (cons (car pareja)
            (expande-pareja (cons (car pareja)
                                  (- (cdr pareja) 1))))))

(check-equal? (expande-pareja '(#f . 5)) '(#f #f #f #f #f))

;-----
; b.1)
;-----

(define (expande-lista lista-parejas)
  (if (null? lista-parejas)
      '()
      (append (expande-pareja (first lista-parejas))
              (expande-lista (rest lista-parejas)))))

(define (expande-parejas . lista-parejas)
  (expande-lista lista-parejas))

(check-equal? (expande-parejas '(#t . 3) '("LPP" . 2) '(b . 4)) 
              '(#t #t #t "LPP" "LPP" b b b b))

;-----
; b.2)
;-----

(define (expande-parejas-2 . lista-parejas)
  (if (null? lista-parejas)
      '()
      (append (expande-pareja (first lista-parejas))
              (apply expande-parejas-2 (rest lista-parejas)))))

(check-equal? (expande-parejas-2 '(#t . 3) '("LPP" . 2) '(b . 4)) 
              '(#t #t #t "LPP" "LPP" b b b b))
;----;
; c) ;
;----;

(define (expande lista)
  (cond
    ((null? lista) '())
    ((number? (first lista))
     (append (expande-pareja (cons (second lista)
                                   (first lista)))
             (expande (rest (rest lista)))))
    (else (cons (first lista) (expande (rest lista))))))

(check-equal? (expande '(4 clase ua 3 lpp aulario))
              '(clase clase clase clase ua lpp lpp lpp aulario))


;--------------;
; Ejercicio 5: ;
;--------------;

;----;
; a) ;
;----;

(check-equal? ((lambda (x) (* x x)) 3) 9)
(check-equal? ((lambda () (+ 6 4))) 10)
(check-equal? ((lambda (x y) (* x (+ 2 y))) (+ 2 3) 4) 30)
;((lambda (x y) (* x (+ 2 x))) 5) ; ⇒ Le falta un argumento:
(check-equal? ((lambda (x y) (* x (+ 2 x))) 5 0) 35)

(define f (lambda (a b) (string-append "***" a b "***")))
(define g f)
(check-true (procedure? g)) ; ⇒ Cierto que g es una función (igual que f):
(check-equal? (g "Hola" "Adios") "***HolaAdios***")

;----;
; b) ;
;----;

(define suma-3
  (lambda (x) (+ x 3)))

(check-equal? (suma-3 2) 5)

(define factorial
  (lambda (x)
    (if (= x 0)
        1
        (* x (factorial (- x 1))))))

(check-equal? (factorial 3) 6)

;----;
; c) ;
;----;

(define (doble x)
   (* 2 x))

(define (foo f g x y)
   (f (g x) y))

(define (bar f p x y)
   (if (and (p x) (p y))
       (f x y)
       'error))

;(foo + 10 doble 15) ; ⇒ 10 debía ser una función de un solo argumento (como doble)
;(foo doble + 10 15) ; ⇒ doble es de un solo argumento y debería permitir dos (como +)
(check-equal? (foo + doble 10 15) 35)
(check-equal? (foo string-append (lambda (x) (string-append "***" x)) "Hola" "Adios")
              "***HolaAdios")

;(bar doble number? 10 15)
; ⇒ Si 10 y 15 son números, doble los debería admilir a los dos como argumentos
(check-equal? (bar string-append string? "Hola" "Adios") "HolaAdios")
;Devuelve el símbolo error en lugar de intentar sumar "Hola" y 5:
(check-equal? (bar + number? "Hola" 5) 'error)


;--------------;
; Ejercicio 6: ;
;--------------;

;----;
; a) ;
;----;

(define (coloca tres-listas un dos tres)
  (list (cons un (first tres-listas))
        (cons dos (second tres-listas))
        (cons tres (third tres-listas))))

(check-equal? (coloca '(() () ()) 'a 'b 'c) '((a) (b) (c)))
(check-equal? (coloca '((a) (a) (a)) 'b 'b 'b) '((b a) (b a) (b a)))
(check-equal? (coloca '((a) (b c) (d e f)) 'g 'h 'i) '((g a) (h b c) (i d e f)))

;----;
; b) ;
;----;

(define (reparte-tres lista-cartas)
  (if (null? lista-cartas)
      '(() () ())
      (coloca (reparte-tres (rest (rest (rest lista-cartas))))
              (first lista-cartas)
              (second lista-cartas)
              (third lista-cartas))))

(check-equal? (reparte-tres '(A♣ 2♣ 3♣ 4♣ 5♣ 6♣ 7♣ 8♣ 9♣ J♣ Q♣ K♣))
              '((A♣ 4♣ 7♣ J♣) (2♣ 5♣ 8♣ Q♣) (3♣ 6♣ 9♣ K♣)))


;----;
; c) ;
;----;

(define (quita-ultimo lista)
  (if (null? (rest lista))
      '()
      (cons (first lista) (quita-ultimo (rest lista)))))

(check-equal? (quita-ultimo '(a b c)) '(a b))

(define (elemento-central lista)
  (if (null? (rest lista))
      (first lista)
      (elemento-central (rest (quita-ultimo lista)))))

(check-equal? (elemento-central '(a b c d e)) 'c)

;----;
; d) ;
;----;

(define (izquierda tres-listas)
  (append (third tres-listas)
          (first tres-listas)
          (second tres-listas)))

(define (centro tres-listas)
  (append (third tres-listas)
          (second tres-listas)
          (first tres-listas)))

(define (derecha tres-listas)
  (append (second tres-listas)
          (third tres-listas)
          (first tres-listas)))

(define adivina elemento-central)


; La siguinte función, con la constante 90 como argumento, genera siempre
; la secuencia aleatoria que permite seguir el ejemplo de los comentarios.
; Si se cambia por otra constante, la secuencia también se reperirá siempre
; aunque será otra. Tener siempre la misma secuencia aleatoria permite poder
; depurar la programación trabajando siempre con el mismo ejemplo aleatorio.

(random-seed 90)

; Si en lugar de una constante se usa un valor variable, se obtiene una
; secuencia aleatoria distinta cada vez que se ejecute el programa. Ejemplo:
; (random-seed (modulo (current-milliseconds) (expt 2 31)))

; La función reparte recoge una lista de 27 cartas al azar para repartir en
; 3 sublistas. Devuelve una lista con las tres sublistas que guardamos en t1.

(define t1 (reparte-tres (cartas 27)))

; Visualiza T1 y escoge una carta, por ejemplo el as de tréboles.
; t1 ⇒ ((J♣ 8♦ K♥ J♠ 2♠ 8♥ Q♣ 4♦ A♥) (5♥ 9♣ 5♦ Q♠ A♦ 9♥ 5♠ 9♦ Q♦) (7♣ 3♠ 6♥ 6♣ 7♥ 3♣ 4♣ A♣ J♥))
t1

; Vamos a pasarle a reparte otra vez una lista con las 27 cartas, pero usando
; para obtener la lista las funciones izquierda, centro o derecha, dependiendo
; de en que sublista de t1 se encuentre la carta elegida.
; En el caso del as de tréboles, que se encuentra en la sublista derecha de t1,
; la función a usar para juntar las tres sublistas es derecha.

(define t2 (reparte-tres (derecha t1)))

; Guardamos esta vez el resultado de reparte en t2. Mostramos el contenido de t2.
; t2 ⇒ (5♥ Q♠ 5♠ 7♣ 6♣ 4♣ J♣ J♠ Q♣) (9♣ A♦ 9♦ 3♠ 7♥ A♣ 8♦ 2♠ 4♦) (5♦ 9♥ Q♦ 6♥ 3♣ J♥ K♥ 8♥ A♥))
t2

; Y repetimos el proceso para obtener un t3. Esta vez, como el as de tréboles se
; encuentra en el centro usamos la función centro.
(define t3 (reparte-tres (centro t2)))

; Mostramos t3
; t3 ⇒ ((5♦ 6♥ K♥ 9♣ 3♠ 8♦ 5♥ 7♣ J♣) (9♥ 3♣ 8♥ A♦ 7♥ 2♠ Q♠ 6♣ J♠) (Q♦ J♥ A♥ 9♦ A♣ 4♦ 5♠ 4♣ Q♣))
t3

; Y volvemos a elegir una de las tres funciones, izquierda, centro o derecha.
; Como el as de tréboles está en derecha otra vez, usaremos la función derecha,
; pero esta vez para pasárle la lista de cartas a la función adivina que debe
; devolver la carta escogida, es decir, el as de tréboles en este caso.
; (adivina (derecho t3)) ⇒ A♣
(adivina (derecha t3))
