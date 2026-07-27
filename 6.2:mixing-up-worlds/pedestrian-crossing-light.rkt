;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pedestrian-crossing-light) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define DEFAULT (rectangle 100 100 "solid" "red"))
(define WALK (rectangle 100 100 "solid" "green"))
(define (FINAL t) 
  (overlay/align "center" "center"
    (text (number->string(round t)) 20 (if(even? (round t)) "green" "orange"))
    (rectangle 100 100 "solid" "grey")
  )
)

(define-struct phase [name countdown])
;a Phase represents the state of the World
;(make-phase PhaseName Countdown)
;a PhaseName is one of:
;-- "default"
;-- "walk"
;-- "final"
;a Countdown is one of:
;-- #false: if PhaseName is default
;-- 10: in any other case

(define (main x)
  (big-bang 
    (make-phase "default" #false)
    [to-draw cl-render]
    [on-key cl-controller]
    [on-tick cl-tick-handler]
  )
)

;Phase->Image
;Given a phase renders a determined light
(check-expect (cl-render (make-phase "default" #false)) DEFAULT)
(check-expect (cl-render (make-phase "walk" 3)) WALK)
(check-expect (cl-render (make-phase "final" 10)) (FINAL 10))
(define (cl-render p) 
  (cond
    [(string=? "default" (phase-name p)) DEFAULT]
    [(string=? "walk" (phase-name p)) WALK]
    [else (FINAL (phase-countdown p))]
  )
)

;Phase->Phase
;Change to the next phase when countdown is zero unless (phase-name p) == "default" in which case does nothing
(define (cl-tick-handler p) 
  (cond
    [(boolean? (phase-countdown p)) p]
    [(zero? (phase-countdown p))(if (string=? "final" (phase-name p))
      (make-phase "default" #false)
      (make-phase "final" 10))
    ] 
    [else (make-phase (phase-name p) (- (phase-countdown p) 0.1))]
  )
)

;Phase KeyEvent->Phase
;If (phase-name p) == "default" and KeyEvent == " " then switch phase to (make-phase "walk" 10)
(define (cl-controller p ke) 
  (cond 
    [(and(string=? ke " ")(string=? (phase-name p) "default"))(make-phase "walk" 10)]
    [else p]
  )
)

(main 0)
