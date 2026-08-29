;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname intersection-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Number] [List-of Number] -> Set
;produces the intersection of two lists
(check-expect (sort (intersection '(1 2 3) '( 3 3 2)) <) '(2 3))
(check-expect (sort (intersection '(1 2 3) '( 3 3 2)) <) '(2 3))
(define (intersection l1 l2)
  (cond
    [(or (empty? l1) (empty? l2)) '()]
    [else 
      (if (member? (first l1) l2) 
          (cons (first l1) (intersection (rest l1) l2))
          (intersection (rest l1) l2))]))
