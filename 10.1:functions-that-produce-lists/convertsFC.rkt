;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname convertsFC) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Numbers is one of:
;--'()
;--(cons Number List-Of-Numbers)
;interpretation: an arbitrary large list of numbers

;Number->Number
;computes the celsius to farenheit formula
(define (ctf c)
  (+ (/ (* c 9) 5) 32)
)

;List-Of-Numbers->List-Of-Numbers
;produces a list with the celsius translated to farenheit
(check-expect (ctf-list (cons 20 (cons 50 empty))) (cons 68 (cons 122 empty)))
(define (ctf-list l)
  (cond
    [(empty? l) '()]
    [else (cons (ctf (first l)) (ctf-list (rest l)))]
  )
)
