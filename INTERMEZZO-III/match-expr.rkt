;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname match-expr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

(define (sum-items l)
  (match l 
    [(cons n '()) n]
    [(cons n r) (+ n (sum-items r))]
  )
)

;[NEList-of X] -> X
;produces the last item of the list
(check-expect (last '(1 2)) 2)
(check-expect (last '(1 2 "a" 5 "c")) "c")
(define (last l)
  (match l
    [(cons x '()) x]
    [(cons x b) (last b)]
  )
)
