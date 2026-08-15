;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname binary-search-trees) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [name ssn left right])
;a BT (short for BinaryTree is one of:
;-- NONE
;-- (make-node Number Symbol BT BT)

(define bt1 
  (make-node 10 'a 
    (make-node 5 'b NONE NONE) 
    (make-node 11 'c NONE 
      (make-node 12 'd NONE NONE)))) 

;BT Number -> Boolean
;yields true if finds n in bt 
(check-expect (contains-bt? bt1 11) #true) 
(check-expect (contains-bt? bt1 41) #false) 
(define (contains-bt? bt n)
  (cond
    [(equal? bt NONE) #false]
    [else 
      (or (equal? n (node-name bt))
          (contains-bt? (node-left bt) n) 
          (contains-bt? (node-right bt) n))]))
