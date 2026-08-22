;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname interpreter-full) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define NOT_FOUND "definition not found")

;a BSL-var-func-expr is one of:
;-- Number
;-- Symbol
;-- Function
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

(define-struct func [name arg])
;a Function is a Structure
;  (make-func Symbol BSL-var-func-expr)
;interpretation: (make-func a b) combines the name of the function (a)
;with its argument

(define-struct cons-def [name value])
;a ConstantDefinition is a structure:
;  (make-cons-def Symbol BSL-expr)
;interpretation: (make-cons-def a b) combines the name (a) 
;and its value (b)

(define-struct func-def [name arg body])
;a FunctionDefinition is a structure:
;  (make-func-def Symbol Symbol BSL-expr)
;interpretation: (make-func-def a b c) combines the function a with
;parameter b and body c

;a Definition is one of:
;-- ConstantDefinition
;-- FunctionDefinition

;a BSL-da-all is a [List-of Definition]

;BSL-da-all Symbol -> ConstantDefinition
;produces the representation of a constant definition
;otherwise throws an error
(check-error (lookup-cons-def '() 't) NOT_FOUND)
(check-expect 
  (lookup-cons-def (list (make-cons-def 'x 50) 
                        (make-func-def 'get 'x (make-add 'x 3))) 'x) 
  (make-cons-def 'x 50))
(define (lookup-cons-def da x)
  (cond
    [(empty? da) (error NOT_FOUND)]
    [else (if (and (cons-def? (first da)) 
                   (symbol=? x (cons-def-name (first da))))
              (first da)
              (lookup-cons-def (rest da) x))]))
