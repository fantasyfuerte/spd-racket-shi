;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fsm-using-local) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define-struct transition [current next])

;Fsm FSM-State -> FSM-State
;matches the keys pressed by a player with the given FSM
(define (simulate fsm s0)
  (local (;State of the World: FSM-State
          ;FSM-State KeyEvent -> FSM-State
          (define (find-next-state s ke)
            (find fsm s)))
  (big-bang s0
    [to-draw state-as-colored-square]
    [on-key find-next-state])))

;FSM-State -> Image
;renders current state as colored square
(define (state-as-colored-square s)
  (square 100 "solid" s))

;FSM FSM-State -> FSM-State
;finds the current state in fsm
(define (find transitions current)
  (cond
    [(empty? transitions) (error "not found")]
    [else
      (local ((define s (first transitions)))
        (if (state=? (transition-current s) current)
            (transition-next s)
            (find (rest transitions) current )))]))


;FSM-State FSM-State->Boolean
;checks the equality of states
(check-expect (state=? "red" "yellow") #false)
(check-expect (state=? "yellow" "yellow") #true)
(define (state=? s1 s2)
  (string=? s1 s2)
)

