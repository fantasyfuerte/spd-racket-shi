;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname structs-predicates) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define p (make-posn 1 2))
(define-struct coordinate [x y])
(define p1 (make-coordinate 1 2))

;here we have 2 structs that looks the same
(posn? p)
(posn? p1)
(coordinate? p)
(coordinate? p1)
