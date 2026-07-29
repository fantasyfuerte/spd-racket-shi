;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname multiply) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;an N is one of:
;-- 0
;-- (add1 N)
;interpretation: represent the counting numbers

;N N->N
;Multiplies two natural numbers without using the operator *
(check-expect (multiply 2 2) 4)
(check-expect (multiply 4 2) 8)
(check-expect (multiply 2 3) 6)
(define (multiply n x)
  (cond
    [(= x 1) n]
    [else (+ n (multiply n (sub1 x)))]
  )
)
