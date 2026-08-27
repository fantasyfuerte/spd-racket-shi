;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname fsm-dsl) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;error string constants
(define NF "not found")

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
            (find transitions current))]))

;[X Y] [List-of [List X Y]] X -> Y
;find the matching Y for the given X in alist
(check-expect (find fsm-traffic '("red" " ")) "green")
(check-error (find fsm-traffic '("red" "0")) NF)
(check-error (find fsm-traffic "rfed") NF)
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error NF))))

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
  '(machine ((initial "red"))
     (action ((state "red") (next "green"))) 
      (action ((state "green") (next "yellow")))
      (action ((state "yellow") (next "red")))))

;XMachine -> FSM-State
;simulates an FSM via the fiven configuration
(define (simulate-xmachine xm)
  (simulate (xm-state0 xm) (xm->transitions xm)))

;XMachine -> FSM-State
;extracts the initial state of xm
(check-expect (xm-state0 xm0) "red")
(define (xm-state0 xm0)
  (find-attr (xexpr-attr xm0) 'initial))

(define fsm-traffic-without-keys
  '(("red" "green") 
   ("green" "yellow")
   ("yellow" "red"))) 

;XMachine -> [List-of 1Transitions]
;translates the embedded list of X1Ts into a [List-of Transitions]
(check-expect (xm->transitions xm0) fsm-traffic-without-keys)
(define (xm->transitions xm) 
  (local(;X1T-> 1Transition
         (define (xaction->action xa)
           (list (find-attr (xexpr-attr xa) 'state)
                 (find-attr (xexpr-attr xa) 'next))))
  (map xaction->action (xexpr-content xm))))

;Xexpr -> [List-of Attributes]
;extracts the attributes of exp
(define (xexpr-attr exp)
  (local(
    (define maybeloa (rest exp))
  )
  (cond
    [(empty? maybeloa) '()]
    [(list-of-attributes? (first maybeloa)) (first maybeloa)]
    [else '()]
  ) 
  )
)

;[List-of Attribute] or Xexpr -> Boolean
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else (if (cons? (first x)) #true #false)] 
  )
)

;Xexpr -> Xexpr
;extracts the content of an xexpr
;#false otherwise
(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (if (list-of-attributes? (first optional-loa+content))
           (rest optional-loa+content)
           optional-loa+content)])))

;[List-of Attributes] Symbol -> FSM-State
;retrieves the value of attribute attr in loa
;if not found throws an error
(define (find-attr loa attr)
  (cond 
    [(empty? loa) (error NF)]
    [else (if (symbol=? attr (first (first loa)))
              (second (first loa))
              (find-attr (rest loa) attr))]
  )
)
