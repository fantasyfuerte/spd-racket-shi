;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname car-moving) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

(define WHEEL-RADIUS 15)
(define DISTANCE-BETWEEN-WHEELS (* WHEEL-RADIUS 3.5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define WHEELS (beside WHEEL (rectangle DISTANCE-BETWEEN-WHEELS 0 "solid" "white") WHEEL))
(define CAR-BODY (above (rectangle (* (image-width WHEEL) 2) (/ (image-width WHEEL) 2) "solid" "beige") (rectangle (* (image-width WHEELS) 1.1) (*(image-height WHEEL) 1.1) "solid" "beige")))
(define CAR (overlay/xy WHEELS 0 (*(image-height WHEEL) -1)  CAR-BODY))

(define tree
  (overlay/xy (circle 15 "solid" "green")
              9 15
              (rectangle 10 30 "solid" "brown")))
(define trees (beside tree (rectangle 100 0 "solid" "white") tree (rectangle 30 0 "solid" "white") tree))

(define SCENE (place-image trees 150 40 (empty-scene 500 70)))
(define CAR-Y-COORDINATE (-(image-height SCENE) (/(image-height CAR)2)))

;WorldState: represents clock ticks since the animation started

;WorldState->Image
;Place the image ws pixels from the left margin of the given image
(define (render ws)
  (place-image CAR (- ws (/ (image-width CAR) 2)) CAR-Y-COORDINATE SCENE)
  )

;WorldState->WorldState
;for each tick of the clock, calculate how distance the car is moving
(define (ontick ws) (* (+ 1 ws) 1.15))

;WorldState->Boolean
;When WorldState = SCENE WIDTH returns true, else false
(define (stop-handler ws)
  (> (- ws (image-width CAR)) (image-width SCENE)))


;big-bang
(define (main x)
  (big-bang x
    [to-draw render]
    [on-tick ontick]
    [stop-when stop-handler]
    ))

(main 0)