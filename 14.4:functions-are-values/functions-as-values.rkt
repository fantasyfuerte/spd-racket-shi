;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname functions-as-values) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define (f x) x)

(define (g x) (x 10)) ; x is a function of course

(define (h x) (x h))  ; evaluates h in x

(define (i x y) (x 'a y 'b)) ;here x must be a function that consumes
;three arguments: a symbol ('a), a parameter y and another symbol 'b
