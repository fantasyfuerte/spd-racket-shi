;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname distance-to-origin) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Posn->Number
;computes the distance of p to the origin
(check-expect (distance-to-0 (make-posn 5 0)) 5)
(check-expect (distance-to-0 (make-posn 0 3)) 3)
(define (distance-to-0 p)
  (sqrt (+
    (sqr (posn-x p))
    (sqr (posn-y p))
  ))
)
