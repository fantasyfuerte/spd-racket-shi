;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname shapes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;A Shape is a function:
;[Posn -> Boolean]
;interpretation: if s in a shape and p a Posn, (s p)
;produces #true if p is in s, #false otherwisea 

;Shape Posn -> Boolean
(define (inside? s p) (s p))
