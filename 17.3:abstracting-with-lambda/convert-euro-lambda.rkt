;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname convert-euro-lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define EXCHANGE-RATE 1.06)

;[List-of Number] -> [List-of Number]
;converts a list of USD to Euro
(define (convert-euro l) 
  (map (lambda (n) (/ n EXCHANGE-RATE)) l))
