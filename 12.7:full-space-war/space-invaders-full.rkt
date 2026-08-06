;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-full) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;SCENE
(define HEIGHT 800)
(define WIDTH 900)
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "black"))
(define BULLETS-VEL 20)

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
(define MAX-UFO-VEL 40)
(define UFO-DESCENDING-VEL 2)

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
(define TANK-VEL 25)
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
      (move-ufo-shots 
        (random-shot (ufo-pos (game-ufo si)) (ufo-shots (game-ufo si))))
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
(define (move-ufo u)
  (make-posn
    (cond
      [(string=? (ufo-dir u) "left") (- (posn-x (ufo-pos u)) (ufo-vel u))]
      [(string=? (ufo-dir u) "right") (+ (posn-x (ufo-pos u)) (ufo-vel u))]
    )
    (+ (if (> (random 10) 8.5) (random 20) 0)
       (posn-y (ufo-pos u)))
  )
)

;Number->Direction
;produces the next moving direction of the ufo
(check-expect (change-ufo-dir (- WIDTH (/ (image-width UFO) 2))) "left")
(check-expect (change-ufo-dir (+ 0 (/ (image-width UFO) 2))) "right")
(define (change-ufo-dir x)
  (cond
    [(>= x (- WIDTH (/ (image-width UFO) 2))) "left"]
    [(<= x (+ 0 (/ (image-width UFO) 2))) "right"]
    [else (if (>= (random 10) 5) "left" "right")]
  )
)

;List-Of-Shots->List-Of-Shots
;produces the next position of every ufo shot unless they're
;under the canvas already
(define (move-ufo-shots l)
  (cond
    [(empty? l) '()]
    [else
      (cond
        [(<= (posn-y (first l)) 0) (move-ufo-shots (rest l))] 
        [else (cons
                (make-posn (posn-x (first l))(+ (posn-y (first l)) BULLETS-VEL))
                (move-ufo-shots (rest l)))
        ]
      )
    ]
  )
)

;List-Of-Shots->List-Of-Shots
;randomly adds a shot to list of shots
(define (random-shot pos l)
  (if (> (random 21) 19)
    (cons (make-posn (posn-x pos) (posn-y pos)) l) 
    l
  )
)

;Number Direction->Number
;produces the next x coordinate of the tank
(check-expect (move-tank 100 "left")
  (- 100 TANK-VEL))
(check-expect (move-tank 40 "right")
  (+ 40 TANK-VEL))
(check-expect (move-tank (/(image-width TANK)2) "left")
  (/ (image-width TANK)2))
(define (move-tank x dir)
  (cond
    [(string=? dir "left") 
      (if (<= x (/ (image-width TANK) 2)) x (- x TANK-VEL))]
    [(string=? dir "right") 
      (if (>= x (- WIDTH (/ (image-width TANK) 2))) x (+ x TANK-VEL))]
  )
)

;List-Of-Shots->List-Of-Shots
;produces the new location of every list of tank's shots
(define (move-tank-shots l)
  (cond
    [(empty? l) '()]
    [else
      (cond
        [(>= (posn-y (first l)) HEIGHT) (move-tank-shots (rest l))] 
        [else (cons
                (make-posn (posn-x (first l))(- (posn-y (first l)) BULLETS-VEL))
                (move-tank-shots (rest l)))
        ]
      )
    ]
  )
)

;SIGS KeyEvent->SIGS
;handles any key press
(define (key-handler si ke)
  (cond
    [(string=? " " ke)
      (make-game 
        (game-ufo si)
        (make-tank (tank-x (game-tank si)) (tank-dir (game-tank si))
          (fire-shot (tank-x (game-tank si)) (tank-shots (game-tank si))))
      )]
    [(string=? "left" ke)
      (make-game
        (game-ufo si)
        (make-tank (tank-x (game-tank si)) "left" (tank-shots (game-tank si)))
       )] 
    [(string=? "right" ke)
      (make-game
        (game-ufo si)
        (make-tank (tank-x (game-tank si)) "right" (tank-shots (game-tank si)))
       )] 
    [else si]
  )
)

;Number List-Of-Shots->List-Of-Shots
;Adds a new shot to tank-shots
(define (fire-shot x l)
  (cons (make-posn x (- Y-TANK 40)) l)
)

;SIGS->Boolean
;stops the game if:
;-- the UFO has been impacted
;-- the Tank has been impacted
;-- the UFO has come to the earth
(define (stop? si) #false)

(main 0)
