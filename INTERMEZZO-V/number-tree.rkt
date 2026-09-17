;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname number-tree) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a Tree is one of:
;-- Number
;-- Pair

(define-struct pair [left right])
;a Pair is a structure:
;  (make-pair Tree Tree)
;interpretation: (make-pair l r) combines the trees l and r

;Tree -> Number
;produces the sum of the numbers in the tree
(check-expect (sum-tree (make-pair (make-pair 1 2) 3)) 6)
(define (sum-tree t)
  (cond
    [(number? t) t]
    [else (+ (sum-tree (pair-left t)) (sum-tree(pair-right t)))]))
