;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname filter-posn-y) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Posn] -> [List-of Posn]
;eliminates posns whose y-coordinate is > 100
(check-expect
  (del>100 
    (list (make-posn 1 1) (make-posn 10 200) (make-posn 3 3) (make-posn 1 100)))
  (list (make-posn 1 1) (make-posn 3 3))) 
(define (del>100 lop)
  (local (
    ;Posn -> Boolean
    ;yields true if the y coordinate is lower than 100
    (define (y-lower-than-100 p) (< (posn-y p) 100))
  )(filter y-lower-than-100 lop))
)
