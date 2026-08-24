;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname xhtml) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

;an Xexpr.v2 is a list:
;-- (cons Symbol Body)

;a Body is one of:
;-- '()
;-- (cons Xexpr.v2 Body)
;-- (cons [List-of Attribute] (cons Body))

;an Attribute is a list of two items:
;  (cons Symbol (cons String '()))

;an XWord is '(word ((text String)))

(define w1 '(word ((text "book"))))
(define w2 '(word ((text "hook"))))
(define w3 '(word ((text "test"))))

;Any -> Boolean
;determines whether any value is a word
(check-expect (word? w1) #true)
(check-expect (word? "word") #false)
(check-expect (word? '(word ((j "j")))) #false)
(define (word? x)
  (match x
    [(list 'word (list (list 'text _))) #true]
    [else #false]
  )
)
