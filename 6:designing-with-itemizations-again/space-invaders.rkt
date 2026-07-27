;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname space-invaders) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define UFO (overlay (circle 15 "solid" "green") (rectangle 60 10 "solid" "green")))
(define TANK (above (above (rectangle 10 10 "solid" "grey")(rectangle 10 20 "solid" "olive")) (rectangle 60 20 "solid" "olive")))
(define MISSILE (triangle 15 "solid" "red"))
(define HEIGHT 600)
(define WIDTH 400)
(define SCENE (rectangle WIDTH HEIGHT "solid" "midnight blue"))
(define Y-TANK (- (image-height SCENE) 20))

;an UFO is a Posn
;(make-posn x y) is the location of the ufo
;(following the top-down, left-to-right convention)

(define-struct tank [loc vel])
;a Tank is a structure:
;(make-tank Number Number)
;(make-tank x dx) specifies the position:
;(x;HEIGHT) and the tank's speed dx pixels per tick

;a Missile is a Posn
;(make-posn x y) is the location of the missile
;(following the top-down, left-to-right convention)

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
;SIGS is one of:
;-- (make-aim ufo tank)
;-- (make-fired ufo tank missile)
;represents the complete state of a space invader game

;a SIGS is the state of the world
(define (main a) 
  (big-bang (make-aim (make-posn (/(image-width SCENE)2) 10) (make-tank 0 3))
    [to-draw si-render]
    [on-tick si-move]
    [stop-when si-game-over?]
    [on-key si-control]
  )
)

;SIGS->Image
;adds TANK, UFO and possibly MISSILE to SCENE
(define (si-render s) 
  (cond
    [(aim? s)(tank-render (aim-tank s)(ufo-render (aim-ufo s) SCENE))]
    [(fired? s)(tank-render (fired-tank s)(ufo-render (fired-ufo s)(missile-render (fired-missile s) SCENE)))]
  )
)

;Tank Image->Image
;adds t to the given image im
(define (tank-render t im) 
  (place-image TANK (tank-loc t) Y-TANK im)
)

;UFO Image->Image
;adds u to the given image im
(define (ufo-render u im) 
  (place-image UFO (posn-x u) (posn-y u) im)
)

;Missile Image->Image
;adds m to the given image im
(define (missile-render m im) 
  (place-image MISSILE (posn-x m) (posn-y m) im)
)

;SIGS->Boolean
;Stops the world if the UFO touch the ground or if the Missile touch the UFO
(define (si-game-over? s)
  (cond
    [(aim? s)(in-ground (aim-ufo s))]
    [(fired? s)(or(in-ground (fired-ufo s))(impacted (fired-missile s) (fired-ufo s)))]
))

;UFO->Boolean
;Check if Ufo is in ground
(define (in-ground u) 
  (= (posn-y u) Y-TANK)
)

;Missile UFO->Boolean
;Check if the missile has impacted the UFO
(define (impacted m u)
  (and (< (abs(- (posn-x u) (posn-x m))) (/(image-width UFO)2)) (< (abs(- (posn-y u) (posn-y m))) (/(image-height UFO)2))) 
)

;SIGS->SIGS
;moves the elements in every clock tick
(define (si-move s) 
  (cond
    [(aim? s)(make-aim (move-ufo (aim-ufo s)) (move-tank (aim-tank s)) )]
    [(fired? s)(make-fired (move-ufo (fired-ufo s)) (move-tank (fired-tank s)) (move-missile (fired-missile s)))]
  )
)

;Tank->Tank
;Moves the fucking tank
(define (move-tank t) 
  (make-tank (+(tank-loc t) (tank-vel t)) (tank-vel t))
)

;UFO->UFO
;Moves the ufo randomly
(define (move-ufo u) 
  (make-posn (random-jump (posn-x u)) (add1 (posn-y u)))
)

;Missile->Missile
;Increments the missile y coordinate with acceleration 
(define (move-missile m) 
  (make-posn (posn-x m) (- (posn-y m) 15))
)

;Number->Number
;Calls (random n) two times, one for see if is increment or decrement and other for see how many pixels is going to move
(define (random-jump n) 
  (cond
    [(> (- (image-width SCENE) n) (-(image-width SCENE)50))(+ n (random 100))]
    [(< (- (image-width SCENE) n) 80) (- n (random 100))]
    [else (if (>(random 10) 5)(+ n (random 40))(- n (random 40)))]   
  )
)

;SIGS->SIGS
;Allows to move the tank and launch the missile
(define (si-control s ke) 
  (cond 
    [(and(string=? ke " ")(aim? s))(make-fired (aim-ufo s) (aim-tank s) (make-posn (tank-loc (aim-tank s)) Y-TANK))]
    [(aim? s)(make-aim (aim-ufo s) (control-tank (aim-tank s) ke))]
    [else (make-fired (fired-ufo s) (control-tank (fired-tank s) ke) (fired-missile s))]
  )
)

;Tank KeyEvent->Tank
;Changes the tank direction depending on the key pressed
(define (control-tank t ke)
  (make-tank (tank-loc t)
    (cond
      [(string=? ke "left")(* -1 (abs (tank-vel t)))]
      [(string=? ke "right")(abs (tank-vel t))]
      [else (tank-vel t)]
    )
  )
)
(main 0)
