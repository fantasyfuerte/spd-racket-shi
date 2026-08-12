;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname is-index-specification-for-index) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; X [List-of X] -> [Maybe N]
;determine the index of the first occurrence of x in l, #false otherwise
(check-satisfied 
  (index "more" '("one" "more" "time"))
  (is-index? "more"'("one" "more" "time")))
(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (add1 i))))]))


;X [List-of X] -> [[List-of X] -> Boolean] 
(define (is-index? x l)
  (lambda (i) 
    (local (
      (define (not-in-list? x l) (not(member? x l)))
      (define (element l)
        (list-ref l i) 
      )
    )
    (or(not-in-list? x l)(equal? x (element l))))
  )
)
