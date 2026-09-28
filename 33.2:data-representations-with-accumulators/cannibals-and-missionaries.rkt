;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname cannibals-and-missionaries) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define MAX 3); max of each

(define-struct puzzle [left right boat])
;a PuzzleState is a structure:
;  (make-puzzle Group Group Boat)
;interpretation: (make-puzzle a b c) combines 
;the group a with the group b and the boat c

;a Boat is one of:
; -- 'left
; -- 'right

(define-struct group [mis can])
;a Group is a structure:
;  (make-group N N)
;interpretation: (make-group 1 2) means that are 
;2 cannibals and 1 missionary

;Graphical Constants

(define SIZE 10)
(define WIDTH (+ (* 2 SIZE) 4))
(define SCENE-HEIGHT (* MAX WIDTH))

(define MIS (overlay (circle SIZE "solid" "brown")
                     (circle (+ 1 SIZE) 'solid 'transparent)))

(define CAN (overlay (circle SIZE "solid" "yellow")
                     (circle (+ 1 SIZE) 'solid 'transparent)))

(define BOAT (above (rhombus SIZE 120 "solid" "blue")
                    (overlay (rectangle (* 2 SIZE) SIZE "solid" "blue")
                             (rectangle (* 3 SIZE) SIZE 'solid 'transparent))))

(define BANK (rectangle (* 2 WIDTH) SCENE-HEIGHT "outline" "green"))

(define RIVER (beside (rectangle 2 SCENE-HEIGHT "solid" "blue")
                      (rectangle (* 5 WIDTH) SCENE-HEIGHT "outline" "blue")
                      (rectangle 2 SCENE-HEIGHT "solid" "blue")))

(define ps-1 (make-ps (make-side 3 3) (make-side 0 0) 'left))
(define ps-2 (make-ps (make-side 2 1) (make-side 1 2) 'right))
(define ps-3 (make-ps (make-side 0 0) (make-side 3 3) 'right))

;PuzzleState -> PuzzleState
;is the final state reachable from state0
;generative creates a tree of possible boat rides
;termination ???
(check-expect (solve initial-puzzle) final-puzzle)
(define (solve state0)
  (local (;[List-of PuzzleState] -> PuzzleState
          ;generative generates the successors of los
          (define (solve* los)
            (cond
              [(ormap final? los)
               (first (filter final? los))]
               [else
                 (solve* (create-next-states los))])))
    (solve* (list state0))))
