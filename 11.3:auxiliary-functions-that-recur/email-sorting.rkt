;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname email-sorting) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct email [from date message])
;an EmailMessage is a structure:
;  (make-email String Number String)
;interpretation: (make-email f d m) represents text m 
;sent by f, d seconds after the beginning of time

;a List-Of-Emails is one of:
;-- '()
;-- (cons EmailMessage List-Of-Emails)
;interpretation: an arbitrary large list of emails

;data examples
(define e1 (make-email "Leo" 4000 "Hi men how are you?"))
(define e2 (make-email "Michelle" 3900 "Hi men how are you?"))
(define e3 (make-email "Leo" 4100 "Hi men how are you?"))
(define e4 (make-email "Juan" 1000 "Hi men how are you?"))

;List-Of-Emails->List-Of-Emails
;sorts a list of emails by date
(check-expect (email-sort>  (list e1 e2 e3 e4)) (list e3 e1 e2 e4))
(check-expect (email-sort>  empty) empty)
(define (email-sort> l) 
  (cond 
    [(empty? l) '()] 
    [else (insert (first l) (email-sort> (rest l)))]
  )
)

;EmailMessage List-Of-Emails->List-Of-Emails
;inserts an email into a sorted list
(define (insert e l)
  (cond
    [(empty? l) (list e)]
    [else( cond
      [(date>? e (first l)) (cons e l)]  
      [else (cons (first l) (insert e (rest l)))]
    )]
  )
)

;EmailMessage EmailMessage->Boolean
;yields true if m1 is recent than m2
(check-expect (date>? e1 e2) #true)
(check-expect (date>? e2 e3) #false)
(check-expect (date>? e3 e4) #true)
(define (date>? m1 m2)
  (>= (email-date m1) (email-date m2))
)
