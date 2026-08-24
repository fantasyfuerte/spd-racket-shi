;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname representing-xml) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;an Xexpr.v0 (short for X-expression) is a one-item list:
;  (cons Symbol '())

;an Xexpr.v1 is a list:
;  (cons Symbol [List-of Xexpr.v1])

;an Xexpr.v2 is a list:
;-- (cons Symbol Body)

;a Body is one of:
;-- '()
;-- (cons Xexpr.v2 Body)
;-- (cons [List-of Attribute] (cons Body))

;an Attribute is a list of two items:
;  (cons Symbol (cons String '()))

(define ex1 '(transition ((from "seen-e") (to "seen-f"))))
(define ex2 '(ul (li (word) (word))(li (word))))

(define a0 '((initial "X")))

(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

;Xexpr.v2 -> [List-of Attribute]
;retrieves the list of attributes of xe
(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) '((initial "X")))
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) '((initial "X")))
(define (xexpr-attr xe) '())
