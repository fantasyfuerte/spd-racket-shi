;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname s-expr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;an S-expr is one of:
;-- Atom
;-- SL

;an Atom is one of:
;-- Number
;-- String
;-- Symbol

;an SL is one of:
;-- '()
;-- (cons S-expr SL)

;Any->Boolean
;yields true if x is an atom
(define (atom? x)
  (or (string? x)
      (number? x)
      (symbol? x)))
