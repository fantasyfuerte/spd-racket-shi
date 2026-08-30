;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname equal-sexp) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

;an S-expr (S-expression) is one of:
;-- Atom
;-- [List-of S-expr]

;an Atom is one of:
;-- Number
;-- String
;-- Symbol

;S-expr S-expr -> Boolean
;yields true if s1 and s2 are equal
(check-expect (sexp=? 3 3) #true)
(check-expect (sexp=? '(9 9) '(9 9)) #true)
(check-expect (sexp=? '(9 9) '(9 a)) #false)
(check-expect (sexp=? '() '(9 a)) #false)
(define (sexp=? s1 s2)
  (cond
    [(and (empty? s1) (empty? s2)) #true]
    [(or (empty? s1) (empty? s2)) #false]
    [(and (atom? s1) 
          (atom? s1)) (equal? s1 s2)]
    [(and (cons? s1)
         (cons? s2)) (for/and ([a s1] [b s2]) (sexp=? a b))]
    [else #false]
  )
)

;Any -> Boolean
;yields true if x is an atomic value
(define (atom? x) (or (symbol? x) (number? x) (string? x)))
