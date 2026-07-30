;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname convert-euro-with-exchange-rate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Numbers is one of:
;--'()
;--(cons Number List-Of-Numbers)
;interpretation: an arbitrary large list of numbers

(define EURO-PRICE 1.14)

;Number->Number
;compute how much euros worth the given d dollars
(define (dollar-to-euro d p)
  (/ d p)
)

;List-Of-Numbers->List-Of-Numbers
;produces a list with the celsius translated to farenheit
(check-expect (dte-list (cons 20 (cons 50 empty)) EURO-PRICE) (cons (dollar-to-euro 20 EURO-PRICE) (cons (dollar-to-euro 50 EURO-PRICE) empty)))
(define (dte-list l p)
  (cond
    [(empty? l) '()]
    [else (cons (dollar-to-euro (first l) p) (dte-list (rest l) p))]
  )
)
