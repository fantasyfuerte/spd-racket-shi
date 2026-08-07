;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname quote-unquote) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define qt (quote (1 2 3)))
(define qt1 '(1 2 3))

(equal? qt qt1) ;#true

'(1 "a" 2 #false 3 "c")
(list 1 "a" 2 #false 3 "c")

'(("alan" 1000)
  ("barb" 2000)
  ("carl" 1500))

(list (list "alan" 1000) (list "barb" 2000) (list "carl" 1500))

(define x 3)

'(1 2 x 4 5)

'(1 (+ 1 1) 3)

