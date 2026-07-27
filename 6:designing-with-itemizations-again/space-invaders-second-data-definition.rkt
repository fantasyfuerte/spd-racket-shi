;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname space-invaders-second-data-definition) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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

(define-struct sigs [ufo tank missile])
;a SIGS represent the state of the world
;(make-sigs Ufo Tank Missile)

(define (main a) 
  (big-bang (make-sigs (make-posn (/(image-width SCENE)2) 10) (make-tank 10 10) #false)
    [to-draw si-render]
    [on-tick si-move]
    [stop-when si-game-over? si-render-final]
    [on-key si-control]
  )
)

;SIGS->Image
;adds TANK, UFO and possibly MISSILE to SCENE
(define (si-render s) 
  (cond
    [(boolean? (sigs-missile s))(tank-render (sigs-tank s)(ufo-render (sigs-ufo s) SCENE))]
    [else (tank-render (sigs-tank s)(ufo-render (sigs-ufo s)(missile-render (sigs-missile s) SCENE)))]
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
    [(boolean? (sigs-missile s))(in-ground (sigs-ufo s))]
    [else (or(in-ground (sigs-ufo s))(impacted (sigs-missile s) (sigs-ufo s)))]
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
    [(boolean? (sigs-missile s))(make-sigs (move-ufo (sigs-ufo s)) (move-tank (sigs-tank s)) #false )]
    [else (make-sigs (move-ufo (sigs-ufo s)) (move-tank (sigs-tank s)) (move-missile (sigs-missile s)))]
  )
)

;Tank->Tank
;Moves the fucking tank
(define (move-tank t) 
  (make-tank  
    (cond
      [(<= (+(tank-loc t) (tank-vel t)) 15)(tank-loc t)]
      [(>= (+(tank-loc t) (tank-vel t)) (- (image-width SCENE) 15))(tank-loc t)]
      [else (+(tank-loc t) (tank-vel t))]
    )
    (tank-vel t))
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
;Allows to control the tank and launch the missile
(define (si-control s ke) 
  (cond 
    [(and(string=? ke " ")(boolean? (sigs-missile s)))(make-sigs (sigs-ufo s) (sigs-tank s) (make-posn (tank-loc (sigs-tank s)) Y-TANK))]
    [(boolean? (sigs-missile s))(make-sigs (sigs-ufo s) (control-tank (sigs-tank s) ke) #false)]
    [else (make-sigs (sigs-ufo s) (control-tank (sigs-tank s) ke) (sigs-missile s))]
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

(define (si-render-final s)
  (text "game over" 20 "black")
)
(main 0)
