#lang racket

;Number->Number
(define (area-of-disk r) 
  (* pi (sqr r))
)

;Any->...
(define (checked-area-of-disk r)
  (cond
    [(and(number? r)(>= r 0))(area-of-disk r)]
    [else (error "POSITIVE NUMBER EXPECTED")]
  )
)

(checked-area-of-disk -10)
(checked-area-of-disk #false)
