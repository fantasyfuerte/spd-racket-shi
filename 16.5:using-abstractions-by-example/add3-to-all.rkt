;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname add3-to-all) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Posn] -> [List-of Posn]
;adds 3 to each x-coordinate on the given list
(check-expect
  (add-3-to-all
    (list (make-posn 3 1) (make-posn 0 0)))
  (list (make-posn 6 1) (make-posn 3 0)))
(define (add-3-to-all lop)
  (local(
    ;Posn -> Posn
    ;adds 3 to the x-coordinate of p
    (define (add3-to-posn p)
      (make-posn (+ 3 (posn-x p)) (posn-y p))
    ))
  (map add3-to-posn lop))  
)
