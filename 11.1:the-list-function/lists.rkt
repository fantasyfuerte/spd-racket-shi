;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define l1 (list "a" "b" "c" "d"))

(define l2 (list (list 1 2)))

(define l3 (list "a" (list (list 1) (list #false))))

(define l4 (list (list "a" (list 2)) (list "hello")))

(define l5 (list (list 1 2) (list (list 2))))

(define c1 (cons 0 (cons 2 (cons 3 (cons 4 (cons 5 '()))))))

(define c2 (cons (cons "he" (cons 0 '())) (cons (cons "it" (cons 1 '())) (cons "lui"(cons 14 '())))))

(define c3 (cons 1 (cons (cons 1 (cons 2 '())) (cons (cons 1 (cons 2 (cons 3 '()))) '())))) 
