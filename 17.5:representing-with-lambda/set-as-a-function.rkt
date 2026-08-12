;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname set-as-a-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a Set is a function
;[Number -> Boolean]
;interpretation: a set is a function that consumes a potenitial element
;and produces #true if that element is in the set

;Element Set -> Boolean
;yields true if x is in set s
(define (is-in-set? x s)
  (s x)
)

;[Number -> Boolean] -> Set
(define (mk-set f)
  (lambda (n)
    (f n)
  )
)

(define odds (mk-set odd?))

;Number Set -> Set
;adds a number to a set
(define (add-element e s)
  (mk-set 
    (lambda (n) 
      (or 
        (is-in-set? n s) 
        (equal? e n)))))

(define odds-and-4 (add-element 4 odds))
