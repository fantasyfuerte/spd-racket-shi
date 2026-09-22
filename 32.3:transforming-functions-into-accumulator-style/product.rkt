;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname product) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Number] -> Number
;computes the product of the numbers on l
(define (product.v1 l)
  (cond
    [(empty? l) 1]
    [else (* (first l) (product.v1 (rest l)))]))

;[List-of Number] -> Number
;computes the product of the numbers on l
(define (product.v2 l0)
  (local (;[List-of Number] Number -> Number
          ;produces the product of the numbers on l
          ;accumulator a is the product so far
          (define (product/a l a)
            (cond
              [(empty? l) a]
              [else (product/a (rest l) (* (first l) a))])))
    (product/a l0 1)))
