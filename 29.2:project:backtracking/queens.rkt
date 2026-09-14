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

(define SQUARE-SIZE 40)
(define QUEEN (place-image (circle 2 "solid" "black") 4 5
 (place-image (circle 2 "solid" "black") 10 4
  (place-image (circle 2 "solid" "black") 15 2
   (place-image (circle 2 "solid" "black") 20 4
    (place-image (circle 2 "solid" "black") 26 5
     (polygon (list (make-posn 0 30)
                    (make-posn 30 30)
                    (make-posn 26 26)
                    (make-posn 20 18)
                    (make-posn 18 12)
                    (make-posn 24 10)
                    (make-posn 26 5)
                    (make-posn 23 8)
                    (make-posn 20 4)
                    (make-posn 17 7)
                    (make-posn 15 2)
                    (make-posn 13 7)
                    (make-posn 10 4)
                    (make-posn 7 8)
                    (make-posn 4 5)
                    (make-posn 6 10)
                    (make-posn 12 12)
                    (make-posn 10 18)
                    (make-posn 4 26)
                    (make-posn 0 30))
              "solid" "black")))))))

(define (paint-square qp) 
  (square SQUARE-SIZE 'solid 
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

;N [List-of QP] Image -> Image
;produces an image of an n x n chess board with the given image
;placed according to the given QPs
(define (render-queens n lqs img)
    (foldr 
      (lambda (a b) 
        (place-image 
          img 
          (- (* SQUARE-SIZE (posn-x a)) (/ SQUARE-SIZE 2))
          (- (* SQUARE-SIZE (posn-y a)) (/ SQUARE-SIZE 2))
          b))
      (board-image n)
      lqs))
