;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname find-root) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[Number -> Number] Number Number -> Numer
;determines R such that f has a root in [R ,(+ R EPSILON)]
;assume: f is continuous
;(2) (or (<- (f left) 0 (f right)) (<= (f right) 0 (f left)))
;generative: divides interval in half, the root is in one of the 
;halves, picks according to (2)
(check-satisfied (find-root poly 3 5) zero?)
(define (find-root f left right)
  0)

;Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))
