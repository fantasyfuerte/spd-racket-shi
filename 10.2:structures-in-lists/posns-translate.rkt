;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname posns-translate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Posns is one of:
;--'()
;--(cons Posn List-Of-Posns)
;interpretation: an arbitrary large list of posns

;eps stands for example posns list
(define epl (cons (make-posn 10 30) (cons (make-posn 3 9) empty)))

;List-Of-Posns->List-Of-Posns
;computes the translation of 1px in the y coordinate
(check-expect (translate epl)(cons (make-posn 10 31) (cons (make-posn 3 10) empty)))
(define (translate l)
  (cond
    [(empty? l) '()]
    [else (cons (make-posn (posn-x (first l)) (add1 (posn-y (first l)))) (translate (rest l)))]
  )
)
