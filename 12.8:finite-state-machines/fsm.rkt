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
(define initial-state "")

;FSM->SimulationState.v1
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

(define-struct fs [fsm current])
;a SimulationState.v2 is a structure:
;  (make-fs FSM FSM-State

;FSM FSM-State-> SimulationState.v2
;match the keys pressed with the fiven FSM
(define (simulate.v2 an-fsm s0)
  (big-bang (make-fs an-fsm s0)
    [to-draw state-as-colored-square]
    [on-key find-next-state.v2]
  )
)

;SimulationState.v2->Image
;renders a world state as an image
(define (state-as-colored-square s)
  (square 50 "solid" (fs-current s))
)

;SimulationState.v2 KeyEvent->SimulationState.v2
;finds the next state from ke and s
(define (find-next-state.v2 s ke)
  (make-fs (fs-fsm s) (get-current (fs-current s) (fs-fsm s)))
)

;FSM-State FSM->FSM
;search the next state
(define (get-current s fsm)
  (cond
    [(empty? fsm) s] 
    [else 
      (cond
        [(state=? s 
          (transition-current (first fsm))) 
          (transition-next (first fsm))]
        [else (get-current s (rest fsm))]
      )
    ]
  )
)
