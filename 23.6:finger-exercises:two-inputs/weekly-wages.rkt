;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname weekly-wages) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct e-card [number hour/week])
;an ElectronicTimeCard is a structure:
;  (make-e-card Number Number)
;interpretation: (make-e-card a b) combines the employee number a with
;the hours worked b

(define-struct e-record [name number pay-rate])
;an EmployeeRecord is a structure:
;  (make-e-record String Number Number)
;interpretation: (make-e-record a b c) combines the name a with the
;number b and the pay-rate c

(define-struct w-record [name wage])

;[List-of EmployeeRecord] [List-of ElectronicTimeCard]
;  -> [List-of WageRecords
;produces the payroll of the employees
(check-expect
  (wages 
    (list 
      (make-e-record "Leandro" 1 10)) 
    (list (make-e-card 1 40))) 
  (list 
    (make-w-record "Leandro" 400)))
(define (wages le lc)
  (cond
    [(empty? le) '()]
    [(empty? lc) (error "something")]
    [else 
      (cons 
        (make-w-record 
          (e-record-name (first le)) 
          (foldr 
            (lambda (a b) 
              (+ (* (e-record-pay-rate (first le))
                    (e-card-hour/week a)) 
              b))
            0
            (filter 
              (lambda (x)
                (= (e-card-number x) 
                   (e-record-number (first le))))
              lc))) 
      (wages (rest le) lc))]))
