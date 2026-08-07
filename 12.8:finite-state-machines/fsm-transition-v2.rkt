;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fsm-transition-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;a FSM is one of:
;-- '()
;-- (cons Transition FSM)

(define-struct transition [current key next])
;a Transition is a structure:
;  (make-transition FSM-State KeyEvent FSM-State)

;FSM-State is a Color

;interpretation: A FSM represents the transitions that a
;finite state machine can take from one state to another
;in reaction to keystrokes

;FSM-State FSM-State->Boolean
;checks the equality of states
(check-expect (state=? "red" "yellow") #false)
(check-expect (state=? "yellow" "yellow") #true)
(define (state=? s1 s2)
  (string=? s1 s2)
)

(define fsm-example (list
  (make-transition "black" "a" "gray")
  (make-transition "gray" "b" "grey")
  (make-transition "grey" "c" "green")
  (make-transition "green" "d" "red")
  (make-transition "red" "e" "white")
  (make-transition "white" "f" "blue"))
)

(define-struct ss [fsm current])
;a SimulationState is a structure:
;  (make-ss FMS FMS-State)

(define (simulate fsm state)
  (big-bang (make-ss fsm state)
    [to-draw state-as-colored-square]
    [on-key find-next-state]
  )
)

;SimulationState->Image
;renders a world state as an image
(define (state-as-colored-square s)
  (square 50 "solid" (ss-current s))
)

;SimulationState KeyEvent->SimulationState
;if the correct key is pressed go to the next state
;if not go to the first
(define (find-next-state s ke)
  (cond
    [(state=? (ss-current s) (state-by-key ke (ss-fsm s)))
      (make-ss (ss-fsm s) (find-next (ss-current s) (ss-fsm s)))]
    [else (make-ss (ss-fsm s) (transition-current (first (ss-fsm s))))]
  )
)

;KeyEvent FSM->FSM-State
;returns the current state of the transition whose key is ke
(define (state-by-key ke fsm) "red")

;FSM-State  FSM->FSM-State
;return the next state
(define (find-next s fsm) s)
