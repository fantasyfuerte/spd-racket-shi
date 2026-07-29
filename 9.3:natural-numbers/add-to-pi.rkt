;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname add-to-pi) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;an N is one of:
;-- 0
;-- (add1 N)
;interpretation: represent the counting numbers

;N->Number
;adds n to pi whithout using the + operator
(check-expect (add-to-pi 1)(+ 1 3.14))
(check-expect (add-to-pi 5)(+ 5 3.14))
(define (add-to-pi n)
  (cond 
    [(= n 0) 3.14]
    [else (add1 (add-to-pi (sub1 n)))]
  )
)
