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

(define-struct employee [name ssn pay-rate])
;an Employee is a structure:
;  (make-employee String String Number)
;interpretation: (make-employee a b c) combines the employee's name (a)
;the employee's ssn (b) and the employee's pay-rate (c)

(define-struct work-record [name hours])
;a WorkRecord is a structure:
;  (make-work-record String Number)
;interpretation: (make-work-record a b) means that employee a has
;worked b hours through the week

(define-struct payroll [name pay])
;a Payroll is a structure:
;  (make-payroll String Number)
;interpretation: (make-payroll a b) means that employee a recieve
;$ (b)

;[List-of Employee] [List-of WorkRecord] -> [List-of Payroll]
;computes the weekly wage of every employee
(check-expect (wages '() '()) '())
(check-expect
  (wages 
    (list (make-employee "Leo" 4040 50))
    (list (make-work-record "Leo" 50)))
  (list (make-payroll "Leo" 2500)))
(define (wages le lwr)
  (local(
    (define (weekly-wage e wr)
      (make-payroll 
        (employee-name e) 
        (* (employee-pay-rate e) (work-record-hours wr)))))
  (for/list ([e le] [wr lwr]) (weekly-wage e wr))))
