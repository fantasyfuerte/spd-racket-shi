;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname queens) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/abstraction)

(define QUEENS 8)
;a QP is a structure
;  (make-posn CI CI)
;a CI as an N in [0, QUEENS).
;interpretation (make-posn r c) denotes the square at the r-th row
;and c-th column

;QP QP -> Boolean
;determines whether the queens are threatening each other
(check-expect (threatening? (make-posn 0 0) (make-posn 1 1)) #true)
(check-expect (threatening? (make-posn 0 0) (make-posn 0 7)) #true)
(check-expect (threatening? (make-posn 4 1) (make-posn 2 3)) #true)
(check-expect (threatening? (make-posn 4 1) (make-posn 3 3)) #false)
(define (threatening? q1 q2)
  (or
    (= (posn-y q1) (posn-y q2))
    (= (posn-x q1) (posn-x q2))
    (= (+ (posn-x q1) (posn-y q1)) (+ (posn-x q2) (posn-y q2)))
    (= (- (posn-x q1) (posn-y q1)) (- (posn-x q2) (posn-y q2)))))

(define (paint-square qp) 
  (square 40 'solid 
          (if 
            (even? 
              (+ (posn-x qp) 
                 (posn-y qp))) 
            'white 'grey)))

(define (board-image n)
  (local (
    (define (create-row y)
      (foldr 
        (lambda (a b) 
          (beside (paint-square a) b)) 
        empty-image
        (for/list ([i n]) (make-posn i y)))))
    (foldr 
      (lambda (a b) (above (create-row a) b)) 
      empty-image
      (build-list n (lambda (x) x)))))
