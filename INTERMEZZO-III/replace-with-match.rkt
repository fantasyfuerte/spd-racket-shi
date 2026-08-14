;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname replace-with-match) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

(define-struct phone [c-code a-code digits])
;a PhoneRecord is a structure:
;  (make-phone Number Number Number)
;interpretation: (make-phone a b c) combines the country-code a,
;the area-code b and the digits c

(define phone-list-example 
  `(,(make-phone 122 455 9090) ,(make-phone 122 713 9898)))
(define phone-list-example-output 
  `(,(make-phone 122 455 9090) ,(make-phone 122 281 9898)))

;[List-of PhoneRecord] -> [List-of PhoneRecord]
;produces a list of the same phone records changin 713 with 281
;in area code
(check-expect (replace phone-list-example) phone-list-example-output)
(define (replace l)
  (for/list ([i l])
    (match i
      [(phone x 713 y) (make-phone x 281 y)]
      [else i]
    )
  )
)
