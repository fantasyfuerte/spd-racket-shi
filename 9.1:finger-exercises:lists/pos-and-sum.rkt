;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pos-and-sum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Number is one of:
;-- '()
;-- (cons Number List-Of-Numbers)
;interpretations: an arbitrary large list of numbers

;a List-Of-Amounts is one of:
;-- '()
;-- (cons PositiveNumber List-Of-Amounts)
;interpretations: an arbitrary large list of transaction's amounts

;List-Of-Numbers->Boolean
;Check if every number in the list is positive
(check-expect (pos? '()) #true)
(check-expect (pos? (cons 30 (cons 20 '()))) #true)
(check-expect (pos? (cons 30 (cons -20 '()))) #false)
(check-expect (pos? (cons -30 (cons 20 '()))) #false)
(define (pos? l) 
  (cond 
    [(empty? l) #true]
    [(<=(first l)0) #false]
    [else (pos? (rest l))]
  )
)

;List-Of-Amounts->Number
;Computes the sum of every amount on the list
(check-expect (sum '()) 0)
(check-expect (sum (cons 10 (cons 20 '()))) 30)
(define (sum l)
  (cond
    [(empty? l) 0]
    [else (+ (first l) (sum (rest l)))]
  )
)

;Any->...
;If the input is a List-Of-Amounts then calls the sum function
(check-expect (checked-sum '()) 0)
(check-expect (checked-sum (cons 10 (cons 20 '()))) 30)
(define (checked-sum l) 
  (cond
    [(pos? l)(sum l)]
    [else (error "checked-sum: argument must be a list of amounts")]
  )
)
