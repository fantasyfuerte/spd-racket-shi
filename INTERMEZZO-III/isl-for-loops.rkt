;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname isl-for-loops) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

(define-struct pair [item index])
;a Pair is a structure:
;  (make-pair Any N)
;interpretation: (make-pair a i) combines the element a with the index i

;[List-of X] -> [List-of Pair]
;produces a list of the same items paired with their relative index
(check-expect 
  (my-enumerate '(1 2 3)) 
  (list (make-pair 1 1) (make-pair 2 2) (make-pair 3 3)))
(check-expect 
  (my-enumerate '("a" "b" "c")) 
  (list (make-pair "a" 1) (make-pair "b" 2) (make-pair "c" 3)))
(define (my-enumerate l)
  (local(
    ;Any Pair->Pair
    ;given an element return a Pair
    (define (pairing a b) 
        (make-pair a (if (empty? b) 1 (add1 (pair-index b))))) 
    ;Any List -> List
    (define (listing a b) (cons (pairing a (if (empty? b) '() (first b))) b))
  )
 (reverse (foldl listing '() l)))
)

;[List-of X] -> [List-of [List N X]]
;pairs each item in lx with its index
(check-expect (enumerate '(a b c)) '((1 a) (2 b) (3 c)))
(define (enumerate lx)
  (for/list ([x lx] [ith (length lx)])
    (list (+ ith 1) x)))

(define (enumerate.v2 lx)
  (for/list ([x lx] [ith (in-naturals 1)])
    (list ith items)))

(define width 2)
(for/list ([width 3] [height width])
  (list width height))

(for*/list ([width 10] [height width])
  (list width height))

;[List-of X] [List-of Y] -> [List-of [List-of X Y]]
;produces pairs of all items from these lists
(check-expect 
  (my-cross '(1 2 3) '(a b c)) 
  '((1 a) (1 b) (1 c) 
     (2 a) (2 b) (2 c) 
     (3 a) (3 b) (3 c)))
(define (my-cross l1 l2)
  (local (
    ;X [List-of Y] -> [List-of [List-of X Y]]
    ;combine x element with all the elements of l2
    (define (combine x) (map (lambda (i) (list x i)) l2)) 
    (define m (map (lambda (x) (append (combine x))) l1))
  )
  (foldr append '() m))
)

;[List-of X] [List-of Y] -> [List-of [List X Y]]
;generates all pairs of items from l1 and l2
(check-satisfied (cross '(a b c) '(1 2))
                 (lambda (c) (= (length c) 6)))
(check-expect (cross '(1 2 3) '(a b c)) (my-cross '(1 2 3) '(a b c)))
(define (cross l1 l2)
  (for*/list ([x1 l1] [x2 l2])
    (list x1 x2)))

;[X -> Boolean] [List-of X] -> [X or #false]
;produces the last value who pass the condition, otherwise #false
(define (and-map f l) 
  (for/and ([i l]) (if (f i) i #false))
)

;[X -> Boolean] [List-of X] -> [X or #false]
;produces the first value who pass the condition, otherwise #false
(define (or-map f l) 
  (for/or ([i l]) (if (f i) i #false))
)
