#lang racket

;Price: Are in one of the next intervals
;--- [0, 1000)
;--- [1000, 10000]
;--- (10000, ∞]

(define LOW 1000)
(define LUXURY 10000)

;Price->Tax
;Given a price returns the sale tax
(check-expect (get-tax 1000) (1000 * 0.05))
(define (get-tax p)
  (cond
    [(< p LOW) 0]
    [(<= p LUXURY) (* p 0.05)]
    [else  (* p 0.08)]
))
