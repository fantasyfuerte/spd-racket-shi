;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname binary-search-trees) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
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
(check-expect (contains-bt? bt1 5) #true) 
(check-expect (contains-bt? bt1 40) #false) 
(define (contains-bt? bt n)
  (cond
    [(equal? bt NONE) #false]
    [else 
      (or (equal? n (node-ssn bt))
          (contains-bt? (node-left bt) n) 
          (contains-bt? (node-right bt) n))]))

;BT Number -> [Symbol or #false]
;produces the name of the node who's ssn is n
(check-expect (search bt1 12) 'd)
(define (search bt n)
  (cond
    [(equal? bt NONE) #false]
    [(not(contains-bt? bt n)) #false]
    [(equal? (node-ssn bt) n) (node-name bt)]
    [(contains-bt? (node-left bt) n) (search (node-left bt) n)] 
    [(contains-bt? (node-right bt) n) (search (node-right bt) n)] 
  )
)

(define bt15 (make-node 15 'a NONE NONE))
(define bt24 (make-node 24 'b NONE NONE))
(define bt89 (make-node 89 'c NONE NONE))
(define bt29 (make-node 29 'd bt15 bt24))
(define bt63 (make-node 63 'e bt29 bt89))
(define bst1 (make-node 1 'a NONE NONE))
(define bst3 (make-node 3 'b NONE NONE))
(define bst5 (make-node 5 'c NONE NONE))
(define bst2 (make-node 2 'd bst1 bst3))
(define bst4 (make-node 4 'e bst2 bst5))

;a BST (short for binary search tree) is a BT according to
;the following conditions:
;-- NONE is always a BST
;-- (make-node ssn0 name- L R) is a BST if
;   -- L is a BST
;   -- R is a BST
;   -- all ssn fields in L are smaller than ssn0
;   -- all ssn fields in R are larger than ssn0

;BT -> [List-of Number]
;produces a list of ssns from left to right as they appear
(check-expect (inorder NONE) '())
(check-expect (inorder bt24) '(24))
(check-expect (inorder (make-node 66 's bt89 NONE)) '(89 66))
(check-expect (inorder (make-node 66 's NONE bt24)) '(66 24))
(check-expect (inorder (make-node 66 's bt89 bt24)) '(89 66 24))
(check-expect (inorder bt63) '(15 29 24 63 89))
(define (inorder bt)
  (cond
    [(equal? NONE bt) '()]
    [else 
      (append 
        (inorder (node-left bt)) 
        (cons (node-ssn bt) (inorder (node-right bt))))]))

;BST Number -> [Symbol or #false]
;produces the name of the node with ssn equal to n, otherwise #false
(check-expect (search-bst bst4 10) #false)
(check-expect (search-bst bst4 3) 'b)
(define (search-bst bst n)
  (cond 
    [(equal? bst NONE) #false] 
    [else 
      (if (= n (node-ssn bst)) (node-name bst)
          (cond
            [(< n (node-ssn bst)) (search-bst (node-left bst) n)]
            [else (search-bst (node-right bst) n)]
          ))]))

;BST N Symbol -> BST
;produces the same bst with a new node properly placed
(check-expect (create-bst bst1 2 'n) 
  (make-node 1 'a NONE (make-node 2 'n NONE NONE))) 
(define (create-bst b n s)
  (cond
    [(no-info? b) (make-node n s NONE NONE)]
    [else (if (> n (node-ssn b)) 
              (make-node (node-ssn b) (node-name b) 
                (node-left b) (create-bst (node-right b) n s)) 
              (make-node (node-ssn b) (node-name b) 
                (create-bst (node-left b) n s)(node-right b)))]))

;[List-of [List Number Symbol]] -> BST
;produces a binary search tree
(define (create-bst-from-list l)
  (foldr (lambda (a b) (create-bst b (first a) (second a))) NONE l)
)
