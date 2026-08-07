;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fsm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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


;FMS-State FMS-State->Boolean
(check-expect (state=? "red" "yellow") #false)
(check-expect (state=? "yellow" "yellow") #true)
(define (state=? s1 s2)
  (string=? s1 s2)
)
