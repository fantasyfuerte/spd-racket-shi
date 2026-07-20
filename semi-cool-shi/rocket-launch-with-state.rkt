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

;State
;-- "in-ground" means that the rocket is in the ground
;-- [-30, -1]: represents the countdown
;-- NonNegativeNumber : represents pixels between the ground and the rocket

(define (main y)
  (big-bang y
    [to-draw render]
    [on-key key-handler]
    [on-tick tick-handler]
    [stop-when stop-handler]
))

;State->State
;if s = "in ground" does nothing
;if (<= -30 s 0) add 1
;if s is a number multiplies it by 1.1
(check-expect (tick-handler "in-ground") "in-ground")
(check-expect (tick-handler -10) -9)
(check-expect (tick-handler 1) 1.1)
(define (tick-handler s)
  (cond
    [(string? s) s]
    [(<= -30 s 0)(add1 s)]
    [else (* s 1.1)]
 ))

;State->Image
;render the rocket on the floor unless s is a NonNegativeNumber
(define (render s)
  (cond 
    [(string? s)(draw-rocket 0)]
    [(> s 0)(draw-rocket s)]
    [else (
      place-image (text (number->string(round(abs(/ s 10)))) 30 "green") 20 20 (draw-rocket 0)
    )]
  ))

;Number->Image
;Creates an image with s pixels betwen the ground and the rocket
(define (draw-rocket y)
  (place-image ROCKET X-ROCKET (- HEIGHT y (image-width ROCKET)) SCENE))

;State KeyEvent->State
;always returns same state unless ke = " "  in which case increment state by 1
(check-expect (key-handler 0 " ") -30)
(check-expect (key-handler 0 "p") 0)
(define (key-handler s ke) 
  (cond
    [(string=? ke " ") -30]
    [else s]
))

;State->Boolean
;Returns #true when rocket is out of sight
(check-expect (stop-handler 10) #false)
(check-expect (stop-handler 2000) #true)
(define (stop-handler s) 
  (cond
    [(number? s)(if(> s (+ HEIGHT (image-height ROCKET)))#true #false)]
    [else #false]
)
)

(main "in-ground")
