;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname words-on-line) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

(define ex-input '(("1" "r") ("ho" "ahoy") ("HELLO" "como" "HEEE")))
(define ex-output '(2 2 3))

;[List-of [List-of String]] -> [List-of Number]
;produces the number of string per item in a list of list of strings
(check-expect (words-on-line ex-input) ex-output)
(define (words-on-line l)
  (for/list ([i l]) (length i))
)
