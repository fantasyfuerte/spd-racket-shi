;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname newtons-method-root) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define EPSILON 0.001)
(define f1 (lambda (i) (+ (* i i) i -2)))
(define f2 (lambda (i) i))

;[Number -> Number] Number -> Number
;produces the slope of f in r1
(check-expect (slope f1 -2.1) -3.2)
(check-expect (slope f1 -3) -5)
(check-expect (slope f2 2) 1)
(check-expect (slope f2 89) 1)
(define (slope f r1)
  (/ (- (f (+ r1 EPSILON)) (f (- r1 EPSILON))) (* 2 EPSILON)))

;[Number -> Number] Number -> Number
;produces the root of the tangent of f in r1
(define (root-of-tangent f r1)
  (- r1 (/ (f r1) (slope f r1))))

;[Number -> Number] Number -> Number
;finds a number r such that (f r) is small
;generative: repeatedly generates improved guesses
(define (newton f r1)
  (cond
    [(<= (abs (f r1)) EPSILON) r1]
    [else (newton f (root-of-tangent f r1))]))
