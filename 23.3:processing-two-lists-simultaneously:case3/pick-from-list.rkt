;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname pick-from-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;N is one of:
;-- 0
;-- (add1 N)

;[List-of Symbol] N -> Symbol
;extracts the nth symbol from l;
;signals an error if there is no such symbol
(check-expect (list-pick '(a b c) 2) 'c)
(check-expect (list-pick '(a b c) 0) 'a)
(check-error (list-pick '() 4) "list too short")
(define (list-pick l n)
  (cond
    [(empty? l) (error "list too short")]
    [(= n 0) (first l)]
    [else (list-pick (rest l) (sub1 n))]
  )
)

