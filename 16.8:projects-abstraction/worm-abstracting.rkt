;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname worm-abstracting) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define APPLE (circle 10 "solid" "red"))
(define BODY (circle 11 "solid" "gold"))
(define HEAD (circle 13 "solid" "orange"))
(define HEIGHT 400)
(define WIDTH 550)
(define MT (empty-scene WIDTH HEIGHT))
(define DISTANCE_PER_TICK (/(image-width HEAD) 2))

(define-struct game [worm food])
;a WormGame is a structure:
;  (make-game Worm Posn)
;interpretation: (make-game w p) means
;that is a worm w and a food in p location

(define-struct worm [head body direction])
;a Worm is a structure:
;  (make-worm Posn List-Of-Posns Direction)
;interpretation: 
;(make-worm (make-posn x y) '() d) is
;a one segment worm whose head is in (x,y) and is moving
;to d direction

;a Direction is one of:
;-- "up"
;-- "down"
;-- "left"
;-- "right"

;a [List-of ITEM] is one of:
;-- '()
;-- (cons ITEM [List-of ITEM])
;interpretation: an arbitrary large list of items

;Number->WorldProgram
(define (main x)
  (big-bang 
    (make-game 
      (make-worm 
        (make-posn x 40) 
        (list 
          (make-posn (- x DISTANCE_PER_TICK) (- 40 DISTANCE_PER_TICK))
        )
         "right") 
      (make-posn (random WIDTH) (random HEIGHT)))
    [to-draw render-game]
    [on-key key-game]
    [on-tick tick-game 0.1]
    [stop-when crashed?]
  )
)

;WormGame->Image
;renders the game
(define (render-game wg)
  (render-apple (game-food wg)
    (render-worm-tail (worm-body (game-worm wg))
      (render-worm-head (worm-head (game-worm wg)))
    )
  )
)

;Posn Image->Image
;renders the worm's food
(define (render-apple a img)
  (place-image 
    APPLE
    (posn-x a)
    (- HEIGHT (posn-y a))
    img
  )
)

;Posn->Image
;renders the worm's head
(define (render-worm-head h)
  (place-image HEAD
    (posn-x h)
    (- HEIGHT (posn-y h))
  MT)
)

;[List-of Posn] Image->Image
;renders the worm's tail into img
(define (render-worm-tail l img)
  (local (
    ;Posn -> Number
    ;returns the y coordinate substracting HEIGHT
    (define (p-y x) (- HEIGHT (posn-y x)))
    ;Posn Image -> Image
    (define (put a b)
      (place-image BODY (posn-x a) (p-y a) b) 
    )
  )
  (foldr put img l))
)

;WormGame KeyEvent->WormGame
;handles the key events of the game
(define (key-game wg ke)
  (cond
    [(or
       (string=? ke "up") 
       (string=? ke "down") 
       (string=? ke "right") 
       (string=? ke "left"))(make-game 
                        (change-direction (game-worm wg) ke) (game-food wg))]
    [else wg]
  )
)

;Worm Direction->Worm
;changes the direction of the worm
(check-expect 
  (change-direction 
    (make-worm (make-posn 0 0) '() "up") "down")
  (make-worm (make-posn 0 0) '() "up"))
(check-expect 
  (change-direction 
    (make-worm (make-posn 0 0) '() "up") "right")
  (make-worm (make-posn 0 0) '() "right"))
(define (change-direction w ke)
  (cond
    [(and (string=? ke "down") (string=? (worm-direction w) "up")) w]
    [(and (string=? ke "up") (string=? (worm-direction w) "down")) w]
    [(and (string=? ke "right") (string=? (worm-direction w) "left")) w]
    [(and (string=? ke "left") (string=? (worm-direction w) "right")) w]
    [else (make-worm (worm-head w) (worm-body w) ke)]
  )
)

;WormGame->WormGame
;decides how the game changes on every clock tick
(define (tick-game wg)
  (local (
    ;Worm->Worm
    ;applies grow-worm to the worm's body
    (define (grow w)
      (make-worm 
        (worm-head w) 
        (grow-worm (worm-body w)) 
        (worm-direction w)))    
    ;Posn->Posn
    ;randomize the food
    (define (randomize food)
      (make-posn 
        (+ (image-width APPLE) (random (- WIDTH (image-width APPLE))))
        (+ (image-height APPLE) (random (- HEIGHT (image-height APPLE)))))
      )
    
    (define worm (game-worm wg))
    (define food (game-food wg))
    (define collided (collide? food (worm-head worm)))
    (define moved-worm (move-worm worm (worm-direction worm)))
    (define new-worm (if collided (grow moved-worm) moved-worm))
    (define new-food (if collided (randomize food) food))
  )
  (make-game new-worm new-food))
)

;[List-of Posns]->[List-of Posns]
;creates one more tail segment
(define (grow-worm t)
  (cond
    [(empty? (rest t))
      (list 
        (first t)
        (make-posn 
          (+ DISTANCE_PER_TICK (posn-x (first t))) 
          (+ DISTANCE_PER_TICK (posn-y (first t)))
        ))
    ]
    [else (cons (first t) (grow-worm (rest t)))]
  )
)

;Worm Direction->Worm
;advances the worm 1 px in d direction
(define (move-worm w d)
  (cond
    [(string=? d "right") 
      (make-worm 
        (make-posn 
          (+(posn-x (worm-head w))DISTANCE_PER_TICK)
          (posn-y (worm-head w))) 
        (move-tail (worm-head w) (worm-body w))
        (worm-direction w))]
    [(string=? d "left") 
      (make-worm 
        (make-posn 
          (- (posn-x (worm-head w))DISTANCE_PER_TICK) 
          (posn-y (worm-head w))) 
        (move-tail (worm-head w) (worm-body w))
      (worm-direction w))]
    [(string=? d "up") 
      (make-worm 
        (make-posn 
          (posn-x (worm-head w))
          (+ (posn-y (worm-head w))DISTANCE_PER_TICK)) 
        (move-tail (worm-head w) (worm-body w))
      (worm-direction w))]
    [(string=? d "down") 
      (make-worm 
        (make-posn 
          (posn-x (worm-head w))
          (- (posn-y (worm-head w))DISTANCE_PER_TICK)) 
        (move-tail (worm-head w) (worm-body w))
        (worm-direction w))]
  )
)

;WormGame->Boolean
;yields true if the worm has crashed into the wall or into himself
(define (crashed? wg)
  (or
    (into-the-walls? (game-worm wg))
    (into-himself (worm-head (game-worm wg)) (worm-body (game-worm wg)))
  )
)

;Worm->Boolean
;yields true if the worm has crashed into the walls
(define (into-the-walls? w)
  (or 
    (>= (posn-y (worm-head w)) HEIGHT)
    (<= (posn-y (worm-head w)) DISTANCE_PER_TICK)
    (>= (posn-x (worm-head w)) WIDTH)
    (<= (posn-x (worm-head w)) DISTANCE_PER_TICK)
  )
)

;Posn [List-of Posns]->Boolean
;yields true if the worm has crashed into himself
(define (into-himself h l)
  (cond 
    [(empty? l) #false]
    [else
      (cond
        [(collide? h (first l)) #true]
        [else (into-himself h (rest l))]
      )]
  )
)

;Posn Posn->Boolean
;check if a has collided with b
(define (collide? a b)
  (and (< (abs (-(posn-x a)(posn-x b))) DISTANCE_PER_TICK )
       (< (abs (-(posn-y a)(posn-y b))) DISTANCE_PER_TICK )))

;Posn [List-of Posns]->[List-of Posns]
;moves the worms tail
(check-expect (move-tail
  (make-posn 20 20)
  (list (make-posn 20 40) (make-posn 40 40) (make-posn 40 60)))
  (list (make-posn 20 20) (make-posn 20 40) (make-posn 40 40))
)
(define (move-tail h l)
  (cond
    [(empty? l) '()]
    [else (cons h (move-tail (first l) (rest l)))]
  )
)

(main 40)

