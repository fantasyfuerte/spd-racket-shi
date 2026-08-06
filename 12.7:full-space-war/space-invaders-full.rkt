;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-full) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;SCENE
(define HEIGHT 700)
(define WIDTH 500)
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "black"))

;UFO
(define UFO 
  (overlay/align "center" "bottom"
    (ellipse 90 20 "solid" "green")
    (circle 15 "solid" "seagreen")
  )
)
(define UFO-SHOT
  (overlay/align "center" "top"
    (ellipse 5 15 "solid" "seagreen")
    (ellipse 15 5 "solid" "green")
  )
)
(define MAX-UFO-VEL 10)
(define UFO-DESCENDING-VEL 5)

;TANK
(define TANK
  (above
    (above/align "center"
      (above
        (rectangle 12 12 "solid" "grey")
        (rectangle 10 30 "solid" "forestgreen")
      )
      (rectangle 90 30 "solid" "forestgreen")
    )
    (beside
      (rectangle 10 15 "solid" "dimgray")
      (rectangle 50 15 "solid" "black")
      (rectangle 10 15 "solid" "dimgray")
    )
  )
)
(define TANK-VEL 5)
(define Y-TANK (- HEIGHT (/ (image-height TANK) 2)))
(define TANK-SHOT 
  (above
    (triangle 10 "solid" "red") 
    (overlay/align "center" "top"
      (rectangle 10 30 "solid" "silver")
      (triangle 20 "solid" "red")
    )
  )
)

(define-struct game [ufo tank])
;a SIGS is a structure:
;(make-game UFO Tank)
;interpretation: (make-game u t) combines the tank and the ufo
;in one state

;a Direction is one of:
;-- "left"
;-- "right"

(define-struct ufo [pos dir vel shots])
;an UFO is a structure:
;(make-ufo Posn Direction Number Lists-Of-Shots)
;interpretation: (make-ufo (make-posn 40 8) "left" 2 '()) means
;that an ufo ,which is 40px from the left margin an 8px from the top
;margin, is moving to the left at 2px per tick and has'nt fired any 
;shots yet

(define-struct tank [x dir shots])
;a Tank is a structure:
;(make-tank Number List-Of-Shots)
;interpretation: (make-tank 5 "right" '()) represents a tank in x=5,
;moving to the right, who haven't fired any shots

;a List-Of-Shots is one of:
;--'()
;-- (cons Posn List-Of-Shots)
;interpretation: an arbitrary large list of posns

;GAME INITIAL STATE
(define GIS 
  (make-game 
    (make-ufo (make-posn (/ WIDTH 2) 0) "left" 3 '())
    (make-tank (/ WIDTH 2) "right" '())
  ))

;Any->WorldProgram
(define (main x)
  (big-bang GIS
    [to-draw render-game]
    [on-tick tick-handler]
    [on-key key-handler]
    [stop-when stop?]
  )
)

;SIGS->Image
;renders an image of the game 
(define (render-game si)
  (render-tank (game-tank si) 
    (render-ufo (game-ufo si)
      BACKGROUND)) 
)

;UFO Image->Image
;renders the UFO and all his shots
(define (render-ufo u img)
  (place-image UFO
    (posn-x (ufo-pos u))
    (posn-y (ufo-pos u))
    (render-shots (ufo-shots u) UFO-SHOT img))
)

;Tank Image->Image
;renders the Tank and all his shots
(define (render-tank t img)
  (place-image TANK
    (tank-x t)
    Y-TANK
    (render-shots (tank-shots t) TANK-SHOT img))
)

;List-Of-Shots Image Image->Image
;renders shots
(define (render-shots l shi img)
  (cond
    [(empty? l) img]
    [else (place-image shi 
      (posn-x (first l))
      (posn-y (first l))
      (render-shots (rest l) shi img))]
  )
)

;SIGS->SIGS
;produces how the game changes after 1 tick
(define (tick-handler si)
  (make-game
    (make-ufo 
      (move-ufo (game-ufo si))
      (change-ufo-dir (posn-x (ufo-pos (game-ufo si)))) 
      (random MAX-UFO-VEL)
      (move-ufo-shots (ufo-shots (game-ufo si)))
    )
    (make-tank
      (move-tank (tank-x(game-tank si)) (tank-dir (game-tank si)))
      (tank-dir (game-tank si))
      (move-tank-shots (tank-shots (game-tank si)))
    )
  )
)

;UFO->Posn
;produces the next position of the UFO
(check-expect
  (move-ufo 
    (make-ufo (make-posn 50 50) "left" 10 '()))
  (make-posn 40 (+ 50 UFO-DESCENDING-VEL))) 
(check-expect
  (move-ufo 
    (make-ufo (make-posn 10 90) "right" 8 '()))
  (make-posn 18 (+ 90 UFO-DESCENDING-VEL))) 
(define (move-ufo u)
  (make-posn
    (cond
      [(string=? (ufo-dir u) "left") (- (posn-x (ufo-pos u)) (ufo-vel u))]
      [(string=? (ufo-dir u) "right") (+ (posn-x (ufo-pos u)) (ufo-vel u))]
    )
    (+ UFO-DESCENDING-VEL (posn-y (ufo-pos u)))
  )
)

;Number->Direction
;produces the next moving direction of the ufo
(define (change-ufo-dir x) "left")

;List-Of-Shots->List-Of-Shots
;produces the next position of every ufo shot unless they're
;under the canvas already
(define (move-ufo-shots l) l)

;Number Direction->Number
;produces the next x coordinate of the tank
(define (move-tank x dir) x)

;List-Of-Shots->List-Of-Shots
;produces the new location of every list of tank's shots
(define (move-tank-shots l) l)

;SIGS KeyEvent->SIGS
;handles any key press
(define (key-handler si ke) si) 

;SIGS->Boolean
;stops the game if:
;-- the UFO has been impacted
;-- the Tank has been impacted
;-- the UFO has come to the earth
(define (stop? si) #false)

(main 0)
