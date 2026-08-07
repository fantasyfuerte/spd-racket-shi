;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fsm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;a FSM is one of:
;-- '()
;-- (cons Transition FSM)

(define-struct transition [current next])
;a Transition is a structure:
;  (make-transition FSM-State FSM-State)

;FSM-State is a Color

;interpretation: A FSM represents the transitions that a
;finite state machine can take from one state to another
;in reaction to keystrokes

(define fsm-traffic (list 
  (make-transition "red" "green")
  (make-transition "yellow" "red")
  (make-transition "green" "yellow")))

(define fsm-bw (list 
  (make-transition "white" "black")
  (make-transition "black" "white")))

;FMS-State FMS-State->Boolean
;checks the equality of states
(check-expect (state=? "red" "yellow") #false)
(check-expect (state=? "yellow" "yellow") #true)
(define (state=? s1 s2)
  (string=? s1 s2)
)

;a SimulationState.v1 is an FSM-State
(define initial-state "white")

;FSM->???
;math the keys pressed with the given FSM
(define (simulate an-fsm)
  (big-bang initial-state
    [to-draw render-state.v1]
    [on-key find-next-state.v1]
  )
)

;SimulationState.v1->Image
;renders the state
(define (render-state.v1 s) empty-image)

;SimulationState.v1 KeyEvent->SimulationState.v1
;changes to the next
(define (find-next-state.v1 s ke) s)
