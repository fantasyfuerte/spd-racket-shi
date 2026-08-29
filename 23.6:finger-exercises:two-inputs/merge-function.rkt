;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname merge-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Number] [List-of Number] -> [List-of Number]
;produces a sorted list with all the elements of the both
(check-expect (merge '(1 2 3) '(3 4 5)) '(1 2 3 3 4 5))
(check-expect (merge '(1 2) '(3 4 5)) '(1 2 3 4 5))
(define (merge l1 l2)(sort (append l1 l2) <))
