;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname car-moving) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define CAR (overlay/xy (overlay (circle 7 "outline" "grey")(circle 10 "solid" "black")) -50 -15 (overlay/xy (overlay (circle 7 "outline" "grey")(circle 10 "solid" "black")) -5 -15 (above (rectangle 40 8 "solid" "beige")(rectangle 80 20 "solid" "beige") ))))
(define SCENE (empty-scene 500 70))

;WorldState: data that represent the state of the world (ws). Is a number.

;WorldState->Image
;Place the image ws pixels from the left margin
(define (render ws)
  (place-image CAR ws 50 SCENE)
  )

;WorldState->WorldState
;for each tick of the clock, adds 3 to the worldstate
(define (ontick ws) (+ 3 ws))

;big-bang
(define (main x)
 (big-bang x
  [to-draw render]
  [on-tick ontick]
))
