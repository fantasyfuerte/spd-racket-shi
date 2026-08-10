;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname convert-euro) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define EXCHANGE-RATE 1.06)

;[List-of Number] -> [List-of Number]
;converts a list of USD to Euro
(define (convert-euro l) 
  (local(
    ;Number -> Number
    ;converts an usd amount to an euro amount
    (define (usd-to-euro n)
      (/ n EXCHANGE-RATE)
    )
  )
  (map usd-to-euro l))
)
