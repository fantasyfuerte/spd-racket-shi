;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname wages) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

;[List-of Number] [List-of Number] -> [List-of Number]
;multiplies the corresponding items on hours and wages/h
;assume the two lists are of equal length
(check-expect (wages*.v2 '() '()) '())
(check-expect (wages*.v2 (list 5.65)(list 40)) '(226.0))
(define (wages*.v2 hours wages/h)
  (for/list ([h hours] [w wages/h])(* w h)))
