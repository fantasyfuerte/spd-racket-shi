;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(lambda (x) (add1 x))

(lambda (x y) (x y y))

(define lexample '(1 2 3 4 5))

(map (lambda (x) (add1 x)) lexample)

;exercise 281
(lambda (x) (< x 10))

(lambda (x y) (number->string (* x y)))

(lambda (x) (if (even? x) 0 1))

(define-struct ir [name desc price])
(lambda (i1 i2) (> (ir-price i1) (ir-price i1)))

(require 2htdp/image)
(define DOT (circle 3 "solid" red))
(lambda (p i) (place-image DOT (posn-x p) (posn-y p) i))
