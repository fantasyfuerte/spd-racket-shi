;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname all-true) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Booleans is one of: 
;-- '()
;-- (cons Boolean List-Of-Booleans)
;interpretation: an arbitrary large list of boolean values

;List-Of-Booleans->Boolean
;yields #true if all values are true
(check-expect (all-true '()) #true)
(check-expect (all-true (cons #true (cons #true '()))) #true)
(check-expect (all-true (cons #true (cons #false '()))) #false)
(define (all-true l)
  (cond
    [(empty? l) #true]
    [(first l) (all-true (rest l))]
    [else #false]
  )
)
