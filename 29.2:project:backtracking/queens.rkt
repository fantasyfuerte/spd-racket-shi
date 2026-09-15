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

;[List-of QP] -> Boolean
;determinas if the given list is a solution to the n-queens problem
(define (n-queens-solution? n l)
  (and (= (length l) n)
       (local (
               (define (check-threats l)
                 (cond
                   [(empty? l) #true]
                   [else (if (ormap (lambda (a) (threatening? a (first l))) (rest l))
                     #false
                     (check-threats (rest l)))])))
         (check-threats l))))

;N -> [Maybe [List-of QP]]
;finds a solution to the n queens problem
;data example: [List-of QP]
(check-satisfied (n-queens 5) (lambda (x) (n-queens-solution? 5 x)))
(check-satisfied (n-queens 6) (lambda (x) (n-queens-solution? 6 x)))
(check-satisfied (n-queens 8) (lambda (x) (n-queens-solution? 8 x)))
(check-satisfied (n-queens 10) (lambda (x) (n-queens-solution? 10 x)))
(define (n-queens n)
  (place-queens (board0 n) n))

(define-struct board [n queens])
;a Board is a structure
; (make-board N [List-of QP])

;Board N -> [Maybe [List-of QP]]
;places n queens on board; otherwise #false
(define (place-queens a-board n)
  (cond
    [(= n 0) '()]
    [else 
      (local (
              (define safe-spots (find-open-spots a-board))
              (define (try spots)
                (cond
                  [(empty? spots) #false]
                  [else (local (
                          (define qp (first spots))
                          (define result 
                            (place-queens 
                              (add-queen a-board qp) (sub1 n)))
                          )
                          (cond
                            [(boolean? result) (try (rest spots))]
                            [else (cons qp result)]))])))
        (try safe-spots)
        )]))


;N -> Board
;creates the initial n by n board
(define (board0 n) (make-board n empty))

;Board QP -> Board
;places a queen at qp on a-board
(define (add-queen a-board qp)
  (if (member? qp (board-queens a-board))
      (error 'add-queen "QP already on board")
      (make-board (board-n a-board)
                  (cons qp (board-queens a-board)))))

;Board -> [List-of QP]
;finds spots where it is still safe to place a queen
(define (find-open-spots a-board)
  (local (
          (define (row i) (foldr 
      (lambda (a b) (add-if-isnt-threatened a i b (board-queens a-board)))
      '() 
      (build-list (board-n a-board) (lambda (x) x))))
          )
  (foldr 
    (lambda (a b) (append (row a) b))
    '()
    (build-list (board-n a-board) (lambda (x) x)))))

(define (add-if-isnt-threatened x y others queens)
  (cond
    [(ormap (lambda (q) (threatening? q (make-posn x y))) queens) others]
    [else (cons (make-posn x y) others)]))
