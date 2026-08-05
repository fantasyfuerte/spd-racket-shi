;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname worms-game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define APPLE (circle 5 "solid" "red"))
(define BODY (circle 11 "solid" "gold"))
(define HEAD (circle 13 "solid" "orange"))
(define HEIGHT 300)
(define WIDTH 350)
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

;a List-Of-Posns is one of:
;-- '()
;-- (cons Posn List-Of-Posns)
;interpretation: an arbitrary large list of posns

;Number->WorldProgram
(define (main x)
  (big-bang 
    (make-game 
      (make-worm 
        (make-posn x 40) 
        (list 
          (make-posn (- x DISTANCE_PER_TICK) (- 40 DISTANCE_PER_TICK))
          (make-posn (- x (* 2 DISTANCE_PER_TICK)) (- 40 (* 2 DISTANCE_PER_TICK)))
          (make-posn (- x (* 3 DISTANCE_PER_TICK)) (- 40 (* 3 DISTANCE_PER_TICK)))
          (make-posn (- x (* 4 DISTANCE_PER_TICK)) (- 40 (* 4 DISTANCE_PER_TICK)))
          (make-posn (- x (* 5 DISTANCE_PER_TICK)) (- 40 (* 5 DISTANCE_PER_TICK)))
          (make-posn (- x (* 6 DISTANCE_PER_TICK)) (- 40 (* 6 DISTANCE_PER_TICK)))
          (make-posn (- x (* 7 DISTANCE_PER_TICK)) (- 40 (* 7 DISTANCE_PER_TICK)))
        )
         "right") 
      (make-posn 30 60))
    [to-draw render-game]
    [on-key key-game]
    [on-tick tick-game 0.1]
    [stop-when crashed?]
  )
)

;WormGame->Image
;renders the game
(define (render-game wg)
  (render-worm-tail (worm-body (game-worm wg))
    (render-worm-head (worm-head (game-worm wg)))
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

;List-Of-Posns->Image
;renders the worm's tail into img
(define (render-worm-tail l img)
  (cond
    [(empty? l) img]
    [else (place-image BODY 
            (posn-x (first l)) 
            (- HEIGHT (posn-y (first l))) 
            (render-worm-tail (rest l) img))]
  )
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
  (make-game
    (move-worm (game-worm wg) (worm-direction (game-worm wg)))
    (game-food wg)
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

;Posn List-Of-Posns->Boolean
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
;check if the head has collide with a body part
(define (collide? h b)
  (and (= (posn-x h) (posn-x b))
       (= (posn-y h) (posn-y b))))

;Posn List-Of-Posns->List-Of-Posns
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
