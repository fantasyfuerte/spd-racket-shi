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

(define fsm-example (list
  (make-transition "black" "a" "gray")
  (make-transition "gray" "b" "grey")
  (make-transition "grey" "c" "green")
  (make-transition "green" "d" "red")
  (make-transition "red" "e" "white")
  (make-transition "white" "f" "blue"))
)


