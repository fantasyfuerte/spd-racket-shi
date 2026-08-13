;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname isl-for-loops) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

(for/list ([i 10]) i)
;this is the equivalent of (build-list 10 (lambda (i) i))

(for/list ([i 10] [j '(a b c d e f g h i j)])
  (list i j))

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
