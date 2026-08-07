;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fire-fighting-game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;SCENE
(define WIDTH 1000)
(define HEIGHT 700)
(define SAND-AMOUNT 0.3)
(define BACKGROUND 
  (above 
    (rectangle WIDTH (- HEIGHT (* SAND-AMOUNT HEIGHT)) "solid" "skyblue")
    (rectangle WIDTH (* SAND-AMOUNT HEIGHT) "solid" "navajowhite")
  )
)

;PLANE
(define PLANE (overlay/xy
  (overlay/align "left" "bottom"
    (right-triangle 23 30 "solid" "yellow") 
    (ellipse 60 20 "solid" "yellow")
  )
    60 8
  (rectangle 2 25 "solid" "darkgray")
))

(define Y-PLANE 80)

(define PLANE-VEL 10)

;FIRE
(define FIRE 
  (overlay 
    (star-polygon 10 11 3 "solid" "red")
    (star-polygon 12 11 3 "solid" "yellow")
    (star-polygon 15 11 3 "solid" "orange")
  )
)

;WATER
(define WATER (circle 5 "solid" "blue"))

(define WATER-DROP-VEL 15)

(define-struct game [plane fires time])
;a Game is a structure:
;(make-game Plane List-Of-Fires Number)
;interpretation: (make-game p f t) combines the plane p
;and the list of fires f and the remaining time t

(define-struct plane [x dir waters])
;a Plane is a structure:
;(make-plane Number Direction Water)
;interpretation: (make-plane 40 "left" (make-water 20 '())) means
;that there is a plane moving to the left at x= 40 who recently 
;hasn't dropped any water and has 20 remaining waters

(define-struct water [count loads])
;a Water is a structure:
;(make-water [Number List-Of-Posns])
;interpretation: (make-water 5 '()) means that there are 5
;remaining waters to be dropped and there is none dropping 
;in this moment

;a List-Of-Fires is one of:
;-- '()
;-- (cons Posn List-Of-Fires)
;interpretation: an arbitrary large list of fires

;a Direction is one of:
;-- "left"
;-- "right"

;a Game is the state of the world
(define IGS  ;INITIAL GAME STATE
  (make-game
    (make-plane 0 "right" (make-water 50 '()))
    '()
    30))

;Number->WorldProgram
(define (main x)
  (big-bang IGS 
    [to-draw render-game]
    [on-tick tick-handler]
    [on-key key-handler]
    [stop-when end?]
  )
)

;Game->Image
;renders the game
(define (render-game g)
  (render-counts (game-time g) (water-count (plane-waters (game-plane g)))
    (render-water (water-loads (plane-waters (game-plane g)))
      (render-fire (game-fires g)
        (render-plane (game-plane g) BACKGROUND)
      )  
    )
  )  
)

;Plane Image->Image
;renders the plane of the game
(define (render-plane p img)
  (place-image 
    (cond
      [(string=? (plane-dir p) "right") PLANE]
      [else (flip-horizontal PLANE)]
    )
    (plane-x p)
    Y-PLANE
    img
  )
)

;List-Of-Fires->Image
;renders the fires of the game
(define (render-fire l img)
  (cond
    [(empty? l) img]
    [else 
      (place-image 
        FIRE
        (posn-x (first l))
        (posn-y (first l)) 
        (render-fire (rest l) img)
      )
    ]
  )
)

;List-Of-Posn Image->Image
;renders the water dropping
(define (render-water l img)
  (cond
    [(empty? l) img]
    [else 
      (place-image 
        WATER 
        (posn-x (first l)) 
        (posn-y (first l)) 
        (render-water (rest l) img))
    ]
  )
)

;Number Number->Image
;places the remaining time and water loads on the top right of the screen
(define (render-counts t wc img)
  (place-image
    (above 
      (above (text "Time remaining" 15 "black")
             (text (number->string (round t)) 20 "black")
      )
      (above (text "WATER remaining" 15 "navy")
             (text (number->string wc) 20 "navy")
      )
    )
    (- WIDTH 80)
    50
    img
  )
)

;Game->Game
;changes the game every clock tick
(define (tick-handler g) 
  (make-game
    (make-plane
      (move-plane (plane-x (game-plane g)) (plane-dir (game-plane g)))
      (plane-dir (game-plane g))
      (make-water (water-count (plane-waters (game-plane g)))
        (move-water 
          (water-loads(plane-waters (game-plane g)))
          (plane-dir (game-plane g))))
    )
    (extinguish-fires 
      (water-loads (plane-waters (game-plane g)))
      (randomize-fires (game-fires g)))
    (decrement-clock (game-time g))
  )
)

;Number Direction->Number
;moves the plane
(define (move-plane x dir)
  (cond
    [(string=? dir "right")(if 
      (>= x (+ WIDTH (image-width PLANE))) 
      0 
      (+ x PLANE-VEL))]
    [else (if 
      (<= x 0) 
      WIDTH 
      (- x PLANE-VEL))]
  )
)

;List-Of-Posns Direction->List-Of-Posns
;moves the waters
(define (move-water l dir)
  (cond
    [(empty? l) '()]
    [else 
      (if (>= (posn-y (first l)) HEIGHT)
        (move-water (rest l) dir)
        (cons 
          (make-posn 
            (if (string=? dir "left") 
              (- (posn-x (first l)) (/ PLANE-VEL 2))
              (+ (posn-x (first l)) (/ PLANE-VEL 2)))
            (+ WATER-DROP-VEL (posn-y (first l)))) 
          (move-water (rest l) dir)))]
  )
)

;List-Of-Fires List-Of-Posns->List-Of-Fires
;if any water load touches a fire this is turned down
(define (extinguish-fires lw lf)
  (cond
    [(empty? lf) '()]
    [else 
      (cond
        [(touch? lw (first lf)) (extinguish-fires lw (rest lf))]
        [else (cons (first lf) (extinguish-fires lw (rest lf)))]
      )
    ]
  )
)

;List-Of-Posns Posn->Boolean
(define (touch? l f)
  (cond
    [(empty? l) #false]
    [else (or 
            (and
              (< (abs(- (posn-x (first l)) (posn-x f))) (/(image-width FIRE)2))
              (< (abs(- (posn-y (first l)) (posn-y f))) (/(image-height FIRE)2))
            )
            (touch? (rest l) f)
          )]
  )
)

;List-Of-Fires->List-Of-Fires
;randomly creates fires at random places
(define (randomize-fires l)
  (if 
    (and (>= (random 40) 39) (< (length l) 10))
    (cons (make-posn (random WIDTH) (- (+ HEIGHT 10) (random (* 0.2 HEIGHT)))) l) l)
)

;Number->Number
;decrements the remaining time
(define (decrement-clock n) (- n 0.02))

;Game KeyEvent->Game
;handles key presses
(define (key-handler g ke)
  (cond
    [(string=? ke "left")
      (make-game
        (make-plane 
          (plane-x (game-plane g))
          "left"
          (plane-waters (game-plane g))
        )
        (game-fires g)
        (game-time g)
      )
    ]
    [(string=? ke "right")
      (make-game
        (make-plane 
          (plane-x (game-plane g))
          "right"
          (plane-waters (game-plane g))
        )
        (game-fires g)
        (game-time g)
      )
    ]
    [(string=? ke " ") 
      (make-game
        (make-plane
          (plane-x (game-plane g))
          (plane-dir (game-plane g)) 
          (drop-water 
            (plane-x (game-plane g))
            (plane-waters (game-plane g)))
        )
        (game-fires g)
        (game-time g)
      )]
    [else g]
  )
)

;Number List-Of-Posns->List-Of-Posns
;adds a posn at (x,Y-PLANE) 
(define (drop-water x w)
  (if (= (water-count w) 0) w 
    (make-water 
      (sub1 (water-count w))
      (cons (make-posn x Y-PLANE) (water-loads w))
    )
  )
)

;Game->Boolean
;ends the game when the remaining waters are 0 or when the time is 0
(define (end? g)
  (or
    (>= 0 (game-time g))
    (and
      (>= 0 (water-count (plane-waters (game-plane g))))
      (= 0 (length (water-loads (plane-waters (game-plane g)))))
    )
  )
)

(main 0)
