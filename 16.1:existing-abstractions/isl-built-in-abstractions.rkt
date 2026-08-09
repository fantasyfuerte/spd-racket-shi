;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname isl-built-in-abstractions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(build-list 10 add1)

(filter odd? (list 1 2 3 4 5))

(sort (list 1 2 3) >)

(map sqr (list 1 3 5 6))

(andmap odd? (list 1 2 3 4 5))

(ormap odd? (list 1 4 2 8))

(foldr + 0 '( 1 2 3 4 5))

;[X] [X -> Number] [NEList-of X] -> X
;finds the (first) item in lx that maximized f
;if (argmax f (list x1 ... xn)) == xi
;then (>- (f xi) (f x1)), (>= (f xi) (fx2)), ...
;(define (argmax f lx) ...)

;returns the list element who maximize the function

(define (f x)
  (if (> x 3) 0 (sqr x))
)
