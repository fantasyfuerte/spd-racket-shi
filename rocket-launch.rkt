;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket-launch) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;CONSTANT DEFINITIONS
(define HEIGHT 500)
(define SCENE (empty-scene 250 HEIGHT))
(define ROCKET (above (triangle 15 'solid 'red) (overlay(rectangle 15 50 'solid 'skyblue)(triangle 30 'solid 'red))))
(define X-ROCKET 130)

;State: Number that represents distance from the ground to the rocket

(define (main y)
  (big-bang y
    [to-draw render]
    [on-key key-handler]
    [on-tick tick-handler]))

;State->State
;multiplies 1.1 for every clock trick unless is 0 in which case does nothing
(check-expect (tick-handler 0) 0)
(check-expect (tick-handler 1) 1.1)
(define (tick-handler s)
  (* s 1.1))

;State->Image
;Creates an image with s pixels betwen the ground and the rocket
(define (render s)
  (place-image ROCKET X-ROCKET (- HEIGHT s (image-width ROCKET)) SCENE))

;State KeyEvent->State
;always returns same state unless ke = " "  in which case increment state by 1
(check-expect (key-handler 0 " ") 1)
(check-expect (key-handler 0 "p") 0)
(define (key-handler s ke) 
  (cond
    [(string=? ke " ") (add1 s)]
    [else s]
))

(main 0)
