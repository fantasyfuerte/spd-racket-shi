;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname refining-interpreters) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a BSL-expr is one of:
;-- Number
;-- Add
;-- Mul

(define-struct add [left right])
;an Add is a structur
; (make-add BSL-expr BSL-expr)
;interpretation: (make-add a b) represents the adition of a and b

(define-struct mul [left right])
;a Mul is a structure 
; (make-mul BSL-expr BSL-expr)
;interpretation: (make-mul a b) means the multiplication of a and b

;a Value is a Number

;BSL-expr -> Value
;computes the value of expr
(check-expect (eval-expression 5) 5)
(check-expect (eval-expression (make-add 2 2)) 4)
(check-expect (eval-expression (make-mul 8 2)) 16)
(check-expect (eval-expression (make-mul (make-add 2 2) 25)) 100)
(define (eval-expression expr)
  (cond
    [(number? expr) expr]
    [(mul? expr) (* (eval-expression (mul-left expr))
                    (eval-expression (mul-right expr)))]
    [(add? expr) (+ (eval-expression (add-left expr))
                    (eval-expression (add-right expr)))]
  )
)
