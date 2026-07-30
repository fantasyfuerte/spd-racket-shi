;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname dollar-to-euro) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Numbers is one of:
;--'()
;--(cons Number List-Of-Numbers)
;interpretation: an arbitrary large list of numbers

(define EURO-PRICE 1.14)

;Number->Number
;compute how much euros worth the given d dollars
(define (dollar-to-euro d)
  (/ d EURO-PRICE)
)

;List-Of-Numbers->List-Of-Numbers
;produces a list with the celsius translated to farenheit
(check-expect (dte-list (cons 20 (cons 50 empty))) (cons (dollar-to-euro 20) (cons (dollar-to-euro 50) empty)))
(define (dte-list l)
  (cond
    [(empty? l) '()]
    [else (cons (dollar-to-euro (first l)) (dte-list (rest l)))]
  )
)
