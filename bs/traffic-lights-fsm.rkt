;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-lights-fsm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)
(define SCENE (empty-scene 250 250))

;TrafficLight: String that represents color of the current light
;--- "green"
;--- "yellow"
;--- "red"

(define (main tl)
  (big-bang tl
    [to-draw light-render]
    [on-key next-light]
))

;String->Image
;Given a color string renders a bulb of that color
(define (bulb c) 
  (circle 30 'solid c)
)

;TrafficLight->TrafficLight
;Given the current state says the next light
(check-expect (next-light "green" " ") "yellow")
(check-expect (next-light "yellow" " ") "red")
(check-expect (next-light "red" " ") "green")
(define (next-light s ke)
  (cond
    [(string=? s "green") "yellow"]
    [(string=? s "yellow") "red"]
    [(string=? s "red") "green"]
    ))

;TrafficLight->Image
;Given the current state renders an image of a bulb of s color
(define (light-render s)
  (place-image (bulb s) 100 100 SCENE))

(main "red")
