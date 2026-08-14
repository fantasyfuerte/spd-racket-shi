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

;Number -> [List-of Numbers]
;creates the list [0 1/n]

;v1
(check-expect (1/n-list.v1 3) `(,(/ 1 1) ,(/ 1 2) ,(/ 1 3)))
(define (1/n-list.v1 n) (for/list ([x n] [i (in-naturals 1)]) (/ 1 i)))

;v2
(check-expect (1/n-list.v2 3) `(,(/ 1 1) ,(/ 1 2) ,(/ 1 3)))
(define (1/n-list.v2 n) (for/list ([x n]) (/ 1 (add1 x))))

;Number -> [List-of Numbers]
;creates a list of the first n even numbers
(check-expect (n-even 5) '(1 3 5 7 9))
(define (n-even n) (for/list ([i n]) (add1 (* 2 i))))

;Number -> [List-of [List-of Number]]
;creates an identity matrix of n x n
(check-expect (identityM 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(define (identityM n) 
  (for/list ([i n]) 
    (for/list ([j n])
      (if (= j i) 1 0)
    )
  )
)
