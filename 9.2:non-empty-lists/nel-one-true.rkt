;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname nel-one-true) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a NEList-Of-Booleans is one of:
;-- (cons Boolean '())
;-- (cons Boolean List-Of-Booleans)
;interpretation: an arbitrary large non-empty-list of boolean values

;NEList-Of-Booleans->Boolean
;yields true if at least one value is #true
(check-expect (one-true (cons #true (cons #false '()))) #true)
(check-expect (one-true (cons #false (cons #false '()))) #false)
(check-expect (one-true (cons #false (cons #false (cons #true '())))) #true)
(check-expect (one-true (cons #false (cons #true '()))) #true)
(define (one-true l)
  (cond
    [(empty? (rest l))(first l)]
    [(first l) #true]
    [else (one-true(rest l))]
  )
)
