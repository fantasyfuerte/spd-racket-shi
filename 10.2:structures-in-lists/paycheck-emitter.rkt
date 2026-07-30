;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname paycheck-emitter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct work [employee rate hours])
;a (piece of) Work is a structure:
;  (make-work Employee Number Number)
;interpretation: (make-work e r h) combines 
;the employee e with the pay rate r and the hours
;worked h

(define-struct employee [name number])
;an employee is a structure:
;  (make-employee String Number)
;interpretation: (make-employee n p) combines
;the name n and the phone number p

;a List-Of-Works is one of:
;-- '()
;-- (cons Work List-Of-Works)
;interpretation: represent the hours worked
;by a list of employees

(define-struct paycheck [name number amount])
;a Paycheck is a structure:
;  (make-paycheck String Number Number)
;interpretation: (make-paycheck n pn am) combines
;the name n the phone number pn and the amount am

;a List-Of-Paychecks is one of:
;-- '()
;-- (cons Paycheck List-Of-Paychecks)
;interpretation: an arbitrary large list of paychecks

(define e-low (cons (make-work (make-employee "Leo" 4150) 20 12)
  (cons (make-work (make-employee "Julia" 4930) 12 6)
    (cons (make-work (make-employee "Pedro" 0850) 5 8)
       empty))))

;List-Of-Works->List-Of-Paychecks
;produces a list of paychecks
(check-expect (payroll e-low) 
  (cons (make-paycheck "Leo" 4150 240)
    (cons (make-paycheck "Julia" 4930 72)
      (cons (make-paycheck "Pedro" 0850 40) empty))))
(define (payroll l)
  (cond
    [(empty? l) empty]
    [else (cons 
      (make-paycheck 
        (employee-name (work-employee (first l))) 
        (employee-number (work-employee (first l))) 
        (* (work-hours (first l)) (work-rate (first l)))
        ) (payroll (rest l)))
    ]
  )
)
