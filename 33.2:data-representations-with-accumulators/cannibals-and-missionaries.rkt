;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname cannibals-and-missionaries) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define MAX 3); max of each
(define CAP 2); max of people the boat can carry

(define-struct puzzle [states left right boat])
;a PuzzleState is a structure:
;  (make-puzzle [List-of PuzzleState] Group Group Boat)
;interpretation: (make-puzzle z a b c) combines 
;the group a with the group b and the boat c and the 
;list of previous states z

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

(define MIS (overlay (circle SIZE "solid" "green")
                     (circle (+ 1 SIZE) 'solid 'transparent)))

(define CAN (overlay (circle SIZE "solid" "red")
                     (circle (+ 1 SIZE) 'solid 'transparent)))

(define BOAT (above (rhombus SIZE 120 "solid" "blue")
                    (overlay (rectangle (* 2 SIZE) SIZE "solid" "blue")
                             (rectangle (* 3 SIZE) SIZE 'solid 'transparent))))

(define BANK (rectangle (* 2 WIDTH) SCENE-HEIGHT "outline" "green"))

(define RIVER (beside (rectangle 2 SCENE-HEIGHT "solid" "blue")
                      (rectangle (* 5 WIDTH) SCENE-HEIGHT "outline" "blue")
                      (rectangle 2 SCENE-HEIGHT "solid" "blue")))

(define ps-1 (make-puzzle '() (make-group 3 3) (make-group 0 0) 'left))
(define ps-2 (make-puzzle '() (make-group 2 1) (make-group 1 2) 'right))
(define ps-3 (make-puzzle '() (make-group 0 0) (make-group 3 3) 'right))

;; PuzzleState -> Image
;; Renders an image according to the given puzzle state.
(define (render-mc state)
  (local ((define (render-actor img n)
            (foldr (lambda (i a) (above img a))
                   empty-image
                   (build-list n (lambda (i) i))))

          (define (render-bank bank)
            (overlay (beside (render-actor MIS (group-mis bank))
                             (render-actor CAN (group-can bank)))
                     BANK)))

    (beside (render-bank (puzzle-left state))
            (overlay/align (puzzle-boat state) "middle" BOAT RIVER)
            (render-bank (puzzle-right state)))))

(render-mc ps-1)
(render-mc ps-2)
(render-mc ps-3)

;PuzzleState -> PuzzleState
;is the final state reachable from state0
;generative creates a tree of possible boat rides
;termination ???
;(check-expect (solve initial-puzzle) final-puzzle)
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

;PuzzleState -> Boolean
;yields true if the game is a final state
(define (final? ps)
  (local (
          ;Group -> Number
          (define (count-people g)
            (+ (group-can g) (group-mis g))))
    (zero? (count-people (puzzle-left ps)))))

;[List-of PuzzleState] -> [List-of PuzzleState]
;produces the successors of the given states
(define (create-next-states s)
  (local (
          ;Boat -> Boat
          (define (flip-boat b)
            (if (equal? b 'left) 'right 'left))

          ;PuzzleState -> Group
          ;the group living on the bank where the boat is
          (define (near-bank ps)
            (if (equal? (puzzle-boat ps) 'left)
                (puzzle-left ps)
                (puzzle-right ps)))

          ;PuzzleState -> Group
          ;the group living on the bank the boat is heading to
          (define (far-bank ps)
            (if (equal? (puzzle-boat ps) 'left)
                (puzzle-right ps)
                (puzzle-left ps)))

          ;PuzzleState -> Boolean
          (define (acceptable? nps)
            (and (legal? nps)
                 (not (seen-before? nps))))

          ;PuzzleState Group -> PuzzleState
          ;sends the people in load from the near bank to the far one,
          ;flipping the side where the boat is
          (define (move ps load)
            (make-puzzle (cons ps (puzzle-states ps))
                         (if (equal? (puzzle-boat ps) 'left)
                             (subtract-group (near-bank ps) load)
                             (add-to-group (far-bank ps) load))
                         (if (equal? (puzzle-boat ps) 'left)
                             (add-to-group (far-bank ps) load)
                             (subtract-group (near-bank ps) load))
                         (flip-boat (puzzle-boat ps))))

          ;PuzzleState -> [List-of PuzzleState]
          (define (successors ps)
            (filter acceptable?
                    (map (lambda (load) (move ps load))
                         (candidate-loads (near-bank ps)))))

          ;[List-of PuzzleState] -> [List-of PuzzleState]
          ;keeps the first of the states that describe the same situation
          (define (dedup los)
            (cond
              [(empty? los) '()]
              [else
                (cons (first los)
                      (filter (lambda (ps) (not (same-state? ps (first los))))
                              (dedup (rest los))))]))
          )
    (dedup (apply append (map successors s)))))

;PuzzleState -> Boolean
;true if both banks are safe, ie the cannibals on no bank
;outnumber the missionaries living there
(define (legal? ps)
  (and (safe-group? (puzzle-left ps))
       (safe-group? (puzzle-right ps))))

;Group -> Boolean
;true if the missionaries of g are safe, ie g has no missionaries
;or at least as many missionaries as cannibals
(define (safe-group? g)
  (or (zero? (group-mis g))
      (>= (group-mis g) (group-can g))))

;Group -> [List-of Group]
;produces the loads the boat can take from g:
; every combination of at most CAP people that g actually has
(define (candidate-loads g)
  (local (
          ;Number -> [List-of Group]
          ;all the loads of exactly n people, missionaries and cannibals
          ;mixed in every possible way
          (define (loads-of-size n)
            (build-list (add1 n) (lambda (i) (make-group (- n i) i))))

          ;Number -> [List-of Group]
          ;all the loads of up to n people
          (define (loads-up-to n)
            (if (zero? n)
                '()
                (append (loads-of-size n) (loads-up-to (sub1 n)))))

          ;Group Group -> Boolean
          (define (fits? load)
            (and (<= (group-mis load) (group-mis g))
                 (<= (group-can load) (group-can g))))
          )
    (filter fits? (loads-up-to CAP))))

;Group Group -> Group
;removes from g the people described by load
(define (subtract-group g load)
  (make-group (- (group-mis g) (group-mis load))
              (- (group-can g) (group-can load))))

;Group Group -> Group
;adds to g the people described by load
(define (add-to-group g load)
  (make-group (+ (group-mis g) (group-mis load))
              (+ (group-can g) (group-can load))))

;PuzzleState -> Boolean
;true if the situation described by ps already shows up
;somewhere in the history accumulated in its states field
(define (seen-before? ps)
  (ormap (lambda (old) (same-state? ps old)) (puzzle-states ps)))

;PuzzleState PuzzleState -> Boolean
;true if both states describe the same situation, ignoring their history
(define (same-state? ps1 ps2)
  (and (= (group-mis (puzzle-left ps1)) (group-mis (puzzle-left ps2)))
       (= (group-can (puzzle-left ps1)) (group-can (puzzle-left ps2)))
       (= (group-mis (puzzle-right ps1)) (group-mis (puzzle-right ps2)))
       (= (group-can (puzzle-right ps1)) (group-can (puzzle-right ps2)))
       (equal? (puzzle-boat ps1) (puzzle-boat ps2))))

;PuzzleState -> [List-of PuzzleState]
;the states that lead to ps, from the initial one, plus ps itself
(define (states-in-order ps)
  (append (reverse (puzzle-states ps)) (list ps)))

;PuzzleState -> Number
;how many people there are altogether, on both banks
(define (total-people ps)
  (+ (+ (group-mis (puzzle-left ps))
        (group-can (puzzle-left ps)))
     (+ (group-mis (puzzle-right ps))
        (group-can (puzzle-right ps)))))
