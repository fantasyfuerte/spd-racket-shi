;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname sets) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a Son.L is one of:
;-- empty
;-- (cons Number Son.L)

;a Son.R is one of:
;-- empty 
;-- (cons Number Son.R)
;constraint: if s is a Son.R no s occurs twice in s
;Son is used when it applies to Son.L and Son.R

;Son
(define es '())

;Number Son->Boolean
;is x in s
(check-expect (in? 2 l1)#true)
(check-expect (in? 1 l2)#true)
(check-expect (in? 10 l2)#false)
(define (in? x s)
  (member? x s)
)

(define l1 (cons 1 (cons 2 (cons 3 empty))))
(define l2 (cons 1(cons 1 (cons 2 (cons 3 empty)))))

;Number Son -> Son
;substracts n from x
(check-expect (set- 1 l2) (cons 2(cons 3 empty)) )
(check-expect (set- 2 l1) (cons 1(cons 3 empty)) )
(define (set- x s)
  (remove-all x s)
)

;Number Son.L->Son.L
;adds a number to a set
(check-expect (set+.L 1 l1) (cons 1 l1))
(check-expect (set+.L 4 l2) (cons 4 l2))
(define (set+.L x s)
  (cons x s)
)

;Number Son.R->Son.R
;adds a number to a set
(check-expect (set+.R 1 l1) l1)
(check-expect (set+.R 4 l2) (cons 4 l2))
(define (set+.R x s)
  (cond
    [(in? x s) s]
    [else (cons x s)]
  )
)
