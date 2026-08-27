;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname fsm-dsl) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;a FSM is a [List-of 1Transition]
;a 1Transition is a list:
;  (list (list FSM-State KeyEvent) FSM-State)
;a FSM-State is a String that specifies a color

;data examples
(define fsm-traffic
  '((("red" " ") "green") 
   (("green" "g") "yellow") 
   (("yellow" "y") "red")))

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
            (find transitions (cons current (cons key-event '()))))]))

;[X Y] [List-of [List X Y]] X -> Y
;find the matching Y for the given X in alist
(check-expect (find fsm-traffic '("red" " ")) "green")
(check-error (find fsm-traffic '("red" "0")) "not found")
(check-error (find fsm-traffic "rfed") "not found")
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))

;an XMachine is a nested list of this shape:
;  (list 'machine (list (list 'initial FSM-State)) [List-of X1T])
;an X1T is a nested list of this shape:
; (list 'action (list (list 'state FSM-State) (list 'next FSM-State)))

;xml representation of a BW-Machine
;<machine initial="red">
;	<action state="black" next="white"/>
;	<action state="white" next="black"/>
;</machine>

(define bw-machine
  '(machine ((initial "black"))
     ((action ((state "black") (next "white")))
      (action ((state "white") (next "black"))))))

(define xm0 
  '(machine ((initial "red))
     ((action ((state "red") (next "green"))) 
      (action ((state "green") (next "yellow")))
      (action ((state "yellow") (next "red"))))))

;XMachine -> FSM-State
;simulates an FSM via the fiven configuration
(define (simulate-xmachine xm)
  (simulate ... ...))

;XMachine -> FSM-State
;extracts the initial state of xm
(check-expect (sm-state0 xm0) "red")
(define (xm-state0 xm0)
  (find-attr (xexpr-attr xm0) 'initial))

;XMachine -> [List-of 1Transitions]
;translates the embedded list of X1Ts into a [List-of Transitions]
(check-expect (xm->transitions xm0) fsm-traffic)

;Xexpr -> [List-of Attributes]
;extracts the attributes of exp
(define (xexpr-attr exp)
  (local(
    (define maybeloa (rest exp))
    (define (list-of-attributes? x)
      (cond
        [(empty? x) #true]
        [else (if (cons? (first x)) #true #false)]
      )
    )
  )
  (cond
    [(empty? maybeloa) '()]
    [(list-of-attributes? maybeloa) maybeloa]
    [else '()]
  ) 
  )
)
