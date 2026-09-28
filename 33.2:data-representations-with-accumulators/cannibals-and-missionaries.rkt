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
