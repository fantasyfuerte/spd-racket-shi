;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname fsm-dsl) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;a FSM is a [List-of 1Transition]
;a 1Transition is a list of three items:
;  (cons FSM-State (cons FSM-State (cons KeyEvent '())))
;a FSM-STate is a String that specifies a color

;data examples
(define fsm-traffic
  '(("red" "green" " ") ("green" "yellow" "g") ("yellow" "red" "y")))

;FSM FSM-State -> FSM-State
;matches the keys pressed by a player with the given FSM
(define (simulate state0 transitions)
  (big-bang state0; FSM-State
    [to-draw 
      (lambda (current) 
        (overlay (text current 30 "black")
                 (square 100 "solid" current)))]
    [on-key 
      (lambda (current key-event)
        (if (string=? key-event (third (assoc current transitions)))
            (find transitions current)
            current))]))

;[X Y] [List-of [List X Y]] X -> Y
;find the matching Y for the given X in alist
(check-expect (find fsm-traffic "red") "green")
(check-error (find fsm-traffic "rfed") "not found")
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))
