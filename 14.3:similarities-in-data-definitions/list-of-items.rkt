;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname list-of-items) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a [List-of ITEM] is one of:
;-- '()
;-- (cons ITEM [List-of ITEM]

(define nlist '(1 2 3))
(define slist '("arbol" "casa" "perro"))

;[List-of Numbers]-> [List-of Numbers]
;dumb function who produces numbers
(define (number-processor l) l)


;[List-of Numbers]-> [List-of Numbers]
;dumb function who produces strings
(define (string-processor l) l)

(define-struct people [name lastname age])
;a People is a structure:
;  (make-people String String Number
;interpretation: (make-people "Juan" "Smith" 40) 
;defines a person named Juan Smith with 40 years old

;[List-of People]->[List-of People]
;dumb function who produces strings
(define (people-processor l) l)
