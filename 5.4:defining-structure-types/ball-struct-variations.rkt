;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ball-bouncing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct ball [pos vel]) 
(define-struct vel [deltax deltay])
(define my-ball 
  (make-ball (make-posn 30 40) (make-vel -10 5)))

(define SPEED 3)
(define-struct balld [position direction])
(define my-other-ball (make-balld (make-posn 30 40) "up"))

(define-struct ball-f [x y deltax deltay])
