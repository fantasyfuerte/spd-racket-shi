;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname special) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(check-expect (getlength '(1 2 3 4)) 4)
(check-expect (getlength '(1 4)) 2)
(check-expect (getlength '()) 0)
(define (getlength P)
  (cond
    [(empty? P) 0]
    [else 
      (add1
        (getlength (rest P)))]))

(check-expect (negatenum '(1 2 3 4)) '(-1 -2 -3 -4))
(define (negatenum P)
  (cond
    [(empty? P) '()]
    [else 
      (cons
        (* -1 (first P))
        (negatenum (rest P)))]))

(check-expect (uppercase '(a b c d)) '(A B C D))
(define (uppercase P)
  (cond
    [(empty? P) '()]
    [else 
      (cons
        (string-upcase (first P))
        (uppercase (rest P)))]))
