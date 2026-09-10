;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname generate-matrix) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;N [List-of-lenght-N^2 N] -> [Matrix N^2]
;produces a n x n matrix
(check-expect 
  (create-matrix 2 '(1 2 3 4))
  (list (list 1 2)
        (list 3 4)))
(define (create-matrix n l) 
  (cond
    [(empty? l) '()]
    [else (cons (take l n) (create-matrix n (drop l n)))]))

;[List-of N] N -> [List-of N]
;takes the first n elements of a list
(define (take l n)
  (cond
    [(= n 0) '()]
    [(empty? l) (error "list is empty")]
    [else (cons (first l) (take (rest l) (sub1 n)))]))

;[List-of N] N -> [List-of N]
;takes the first n elements of a list
(define (drop l n)
  (cond
    [(= n 0) l]
    [(empty? l) (error "list is empty")]
    [else (drop (rest l) (sub1 n))]))
