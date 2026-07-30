;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname posns-sum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Posns is one of:
;--'()
;--(cons Posn List-Of-Posns)
;interpretation: an arbitrary large list of posns

;eps stands for example posns list
(define epl (cons (make-posn 10 30) (cons (make-posn 3 9) empty)))

;List-Of-Posns->Number
;produces the sum of the x-coordinates of l's elements
(check-expect (posns-sum epl) 13)
(define (posns-sum l)
  (cond
    [(empty? l) 0]
    [else (+ (posn-x (first l)) (posns-sum (rest l))) ]
  )
)
