;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 289-290-291) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;exercise 289
(check-expect (find-name "one" '("onee" "two")) #true)
(check-expect (find-name "0one" '("onee" "two")) #false)
(define (find-name n l)
  (ormap (lambda (x) (string-contains? n x)) l) 
)

(check-expect (start-with-a? '("a" "ab")) #true)
(check-expect (start-with-a? '("r" "ab")) #false)
(define (start-with-a? l)
  (andmap (lambda (x) (string=? "a" (first (explode x)))) l) 
)

;exercise 290
(check-expect (append-from-fold '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))
(define (append-from-fold l1 l2)
  (foldr (lambda (a b) (cons a b)) l2 l1)
)
