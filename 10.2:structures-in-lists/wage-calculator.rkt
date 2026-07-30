;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname wage-calculator) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct work [employee rate hours])
;a (piece of) Work is a structure:
;  (make-work String Number Number)
;interpretation: (make-work n r h) combines 
;the name n with the pay rate r and the hours
;worked h

;a List-Of-Works is one of:
;-- '()
;-- (cons Work List-Of-Works)
;interpretation: represent the hours worked
;by a list of employees

;a List-Of-Numbers is one of:
;-- '()
;-- (cons Number List-Of-Numbers)
;interpretation: represents an arbitrary large list of numbers

(define e-low (cons (make-work "Leo" 20 12)
  (cons (make-work "Julia" 12 6)
    (cons (make-work "Chriss" 5 8)
       empty))))

;List-Of-Works->List-Of-Numbers
;produces a list of wages
(check-expect (wages e-low) (cons 240 (cons 72 (cons 40 empty))))
(define (wages l)
  (cond 
    [(empty? l) empty]
    [else (cons
      (* (work-hours (first l)) (work-rate (first l))) (wages (rest l)))
    ]
  )
)
