;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname shapes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;A Shape is a function:
;[Posn -> Boolean]
;interpretation: if s in a shape and p a Posn, (s p)
;produces #true if p is in s, #false otherwisea 

;Shape Posn -> Boolean
(define (inside? s p) (s p))

;Posn -> Boolean
(lambda (p) (and (= (posn-x p) 3) (= (posn-y p) 4)))

;Number Number -> Shape
;represents a point at (x,y)
(check-expect (inside? (mk-point 3 4) (make-posn 3 4)) #true)
(check-expect (inside? (mk-point 3 4) (make-posn 3 9)) #false)
(define (mk-point x y)
  (lambda (p)
    (and (= (posn-x p) x) (= (posn-y p) y))))

;Number Number Number -> Shape
;creates a representation for a circle of radius r
;located at (center-x, center-y)
(check-expect (inside? (mk-circle 3 4 5) (make-posn 0 0)) #true)
(check-expect (inside? (mk-circle 3 4 5) (make-posn 10 9)) #false)
(define (mk-circle center-x center-y r)
  (lambda (p) 
   (local (
     (define distance (sqrt
      (+ (sqr (- center-x (posn-x p))) 
         (sqr (- center-y (posn-x p))))))
  )
  (<= distance r)) 
  )
)

;Number Number Number Number -> Shape
;represents a width by height rectangle whose upper-left corner is
;located at (ul-x, ul-y)
(check-expect (inside? (mk-rect 0 0 10 3)
  (make-posn 0 0))
  #true)
(check-expect (inside? (mk-rect 2 3 10 3)
  (make-posn 4 5))
  #true)
(check-expect (inside? (mk-rect 0 0 10 5)
  (make-posn 1 1))
  #true)
(define (mk-rect ul-x ul-y width height)
  (lambda (p)
    (and (<= ul-x (posn-x p) (+ ul-x width))
         (<= ul-y (posn-y p) (+ ul-y height)))))
