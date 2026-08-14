;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise-306) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

;Number -> [List-of Numbers]
;creates the list [0 n)
(check-expect (n-1-list 5) '(0 1 2 3 4))
(define (n-1-list n) (for/list ([x n]) x))

;Number -> [List-of Numbers]
;creates the list [0 n]

;v1
(check-expect (n-list.v1 5) '(1 2 3 4 5))
(define (n-list.v1 n) (for/list ([x n]) (add1 x)))

;v2
(check-expect (n-list.v2 5) '(1 2 3 4 5))
(define (n-list.v2 n) (for/list ([x n] [i (in-naturals 1)]) i))
