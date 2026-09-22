;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname binary-tree-height) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct node [left right])
;a Tree is one of:
;-- '()
;-- (make-node Tree Tree)
(define example
  (make-node 
    (make-node 
          '() 
          (make-node 
            '() 
            '())) 
    '()))

;Tree -> Number
;produces the height of the tree
(check-expect (height example) 3)
(define (height bt)
  (cond
    [(empty? bt) 0]
    [else (+ (max (height (node-left bt))
                  (height (node-right bt))) 1)]))

;produces the height of the tree
(check-expect (height.accu example) 3)
(define (height.accu bt0)
  (local (;Tree ??? -> Number
          ;measures the height of the tree
          ;accumulator: a is the number of steps 
          ;it takes to rack bt from bt0
          (define (height/a bt a)
            (cond
              [(empty? bt) a]
              [else (max (height/a (node-left bt)
                                   (add1 a))
                         (height/a (node-right bt)
                                   (add1 a)))])))
    (height/a bt0 0)))
