;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname sum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Number] -> Number
;produces the sum of the numbers on l
(check-expect (sum.v1 '(1 2 3 4 5)) 15)
(check-expect (sum.v1 '()) 0)
(define (sum.v1 l)
  (cond
    [(empty? l) 0]
    [else (+ (first l) (sum.v1 (rest l)))]))

;[List-of Number] -> Number
;produces the sum of the numbers on l
(check-expect (sum.v2 '(1 2 3 4 5)) 15)
(check-expect (sum.v2 '()) 0)
(define (sum.v2 l0)
  (local (;[List-of Number] ??? -> Number
          ;computes the sum of the numbers on l
          ;accumulator ...
          (define (sum/a l a)
            (cond
              [(empty? l) ...]
              [else (... (sum/a (rest l)
                                ... a ...)...)])))
    (sum/a l0 ...)
