;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname distance-from-3d-point-to-origin) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct point [x y z])
;a Point is a structure
; (make-point Number Number Number)
;(make-point 3 5 9) is a point located at x=3 y=5 z=9

;a Distance is a Number

;Point->Distance
(define (get-distance p) 
  (sqrt (+ (sqr (point-x p))(sqr (point-y p))(sqr (point-z p))))
)

(define p1 (make-point 1 0 0))
(define p2 (make-point 3 4 1))

(get-distance p1)
(get-distance p2)
