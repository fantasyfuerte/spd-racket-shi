;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(lambda (x) (add1 x))

(lambda (x y) (x y y))

(define lexample '(1 2 3 4 5))

(map (lambda (x) (add1 x)) lexample)
