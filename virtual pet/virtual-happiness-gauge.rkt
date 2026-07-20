;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname virtual-happiness-gauge) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define BACKGROUND-WIDTH 250)
(define BACKGROUND (overlay(rectangle BACKGROUND-WIDTH (/ BACKGROUND-WIDTH 3) "outline" "black")
                           (empty-scene BACKGROUND-WIDTH (/ BACKGROUND-WIDTH 3))))

(define RED-BAR (rectangle (- BACKGROUND-WIDTH 2) (-(/ BACKGROUND-WIDTH 3)2) "solid" "red"))

(define Y-IMAGE (/ (image-height BACKGROUND) 2))
(define X-IMAGE (/ BACKGROUND-WIDTH 2))

;State: Number that represents the percent of completion of the happiness bar

(define (gauge-prog s)
  (big-bang s
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]
    ))

;State->Image
;Takes the state given by big-bang and paints the red bar (state)% over the frame
(define (render s)
  (place-image (text (number->string (round s)) 20 "black") X-IMAGE Y-IMAGE 
  (place-image RED-BAR (* X-IMAGE (/ s 100)) Y-IMAGE BACKGROUND))
  )

;State->State
;Takes the state and substracts 0.1
;given 3.6 expects 3.5
(define (tick-handler s)
  (if (> s 0)(- s 0.1)0))
(check-expect (tick-handler 3.6) 3.5)

;State KeyEvent-> State
;Given a State increase happiness 1.5X if KeyEvent is "down" and 1.3X if is "up"
;given 50 "up" expects: 75
;given 50 "down" expects: 65
(define (key-handler s ke)
  (cond
    [(> s 100) 100]
    [(string=? ke "up")(if(<= 100(* s 1.3))100 (* 1.3 s))]
    [(string=? ke "down")(if(<= 100(* s 1.5))100 (* 1.5 s))]
    [else s]
  ))
(check-expect (key-handler 50 "up") 65)
(check-expect (key-handler 50 "down") 75)



(gauge-prog 100)