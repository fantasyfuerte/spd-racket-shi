;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname automatic-door-closer) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define LOCKED "locked")  ;DoorState is one of:
(define CLOSED "closed") ;--- LOCKED
(define OPEN 0)          ;--- CLOSED
           		 ;--- OPEN

(define SCENE (empty-scene 200 200))
(define OPEN-TIME 30)

;Main
(define (main s) 
  (big-bang s
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]
    )
)

;DoorState KeyEvent->DoorState
;valid ke is one of:
;--- " " for pushing the door
;--- "u" for unlocking the door
;--- "l" for locking the door
(check-expect (key-handler CLOSED " ") OPEN) 
(check-expect (key-handler CLOSED "u") CLOSED) 
(check-expect (key-handler CLOSED "l") LOCKED) 
(check-expect (key-handler OPEN "l") OPEN) 
(check-expect (key-handler OPEN "u") OPEN) 
(check-expect (key-handler OPEN " ") OPEN) 
(check-expect (key-handler LOCKED " ") LOCKED) 
(check-expect (key-handler LOCKED "l") LOCKED) 
(check-expect (key-handler LOCKED "u") CLOSED) 
(define (key-handler s ke)
  (cond
    [(number? s) s]
    [(string=? ke " ")(if(string=? s CLOSED)OPEN s)]
    [(string=? ke "u")(if(string=? s LOCKED)CLOSED s)]
    [(string=? ke "l")(if(string=? s CLOSED)LOCKED s)]
    [else s]
  )
)

;DoorState->DoorState
;If s is OPEN changes to CLOSE
;else does nothing
(check-expect (tick-handler OPEN) (add1 OPEN))
(check-expect (tick-handler LOCKED) LOCKED)
(check-expect (tick-handler CLOSED) CLOSED)
(define (tick-handler s) 
  (cond 
    [(number? s)(if(> s OPEN-TIME)CLOSED (add1 s))]
    [else s])
)

;DoorState->Image
;returns a text of the state
(define (render s)
  (cond
    [(number? s)(place-image (text (number->string(round (/ s 10))) 20 "black") 50 50 SCENE)]
    [else (place-image (text s 20 "black") 50 50 SCENE)]
  )
)
  
(main CLOSED) 
