;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname nodes-connected) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a SimpleGraph is a [List-of Connection]
;a Connection is a list of two items:
;  (list Node Node)
;a Node is a Symbol

(define a-sg '(
               (A B)
               (B C)
               (C E)
               (D E)
               (E B)
               (F F)
               ))
