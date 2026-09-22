;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname how-many) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of X] -> Number
;produces the length of the list
(define (how-many l)
  (cond
    [(empty? l) 0]
    [else (add1 (how-many (rest l)))]))

;[List-of X] -> Number
;produces the length of the list
(define (how-many.accu l0)
  (local (;[List-of X] Number -> Number
          ;produces the length of the list
          (define (how-many/a l a)
            (cond 
              [(empty? l) a]
              [else (how-many/a (rest l) (add1 a))])))
    (how-many/a l0 0)))

;if n is the length of l then the performance of space the first is O(n) 
;while the performance of the accumulator's version is O(1)
