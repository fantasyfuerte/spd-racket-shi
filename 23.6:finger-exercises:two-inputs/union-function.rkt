;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname union-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a Set is one of:
;-- '()
;-- (cons Number Set)
;constraint: no number appears twice

;[List-of Number] [List-of Number] -> Set
;produces the union of two sets
(check-expect (sort (union '(1 2 3) '(1 2 3 4)) <) '(1 2 3 4))
(check-expect (sort (union '(1 3 4) '(2 5 6)) <) '(1 2 3 4 5 6))
(define (union l1 l2)
  (cond
    [(empty? l2) l1]
    [else 
      (union 
        (if (member? (first l2) l1) l1 (append l1 (list (first l2)))) 
        (rest l2))]))
