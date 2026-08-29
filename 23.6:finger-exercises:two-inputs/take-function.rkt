;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname take-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Number] N -> [List-of Items]
;produces the first n items on the list
(check-expect (take '(1 2 3 4 5) 3) '(1 2 3))
(check-expect (take '(1 2) 10) '(1 2))
(define (take l n)
  (cond
    [(or (= n 0) (empty? l)) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
