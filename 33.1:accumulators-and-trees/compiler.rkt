;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname compiler) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a Lam is one of:
;-- a Symbol
;-- (list 'λ (list Symbol) Lam)
;-- (list Lam Lam)

;examples
(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ(x) (x x)) (λ (x) (x x))))

(define (is-var? exp) (symbol? exp))
(define (is-λ exp) (and (cons? exp)
                        (= (length exp) 3)))
(define (is-app? exp) (and (cons? exp)
                           (= (length exp) 2)))
(define (λ-para exp) (first (second exp)))
(define (λ-body exp) (third exp))

