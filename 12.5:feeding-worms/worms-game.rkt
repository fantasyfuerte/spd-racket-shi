;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname worms-game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define APPLE (circle 5 "solid" "red"))
(define BODY (circle 10 "solid" "yellow"))
(define HEAD (circle 13 "solid" "orange"))
(define HEIGHT 300)
(define WIDTH 350)
(define MT (empty-scene WIDTH HEIGHT))

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
      (make-worm (make-posn x 10) '() "right") 
      (make-posn 30 60))
    [to-draw render-game]
    [on-key key-game]
    [on-tick tick-game]
    [stop-when crashed?]
  )
)

;WormGame->Image
;renders the game
(define (render-game wg) MT)

;WormGame KeyEvent->WormGame
;handles the key events of the game
(define (key-game wg ke) wg)

;WormGame->WormGame
;decides how the game changes on every clock tick
(define (tick-game wg) wg)

;WormGame->Boolean
;yields true if the worm has crashed into the wall or into herself
(define (crashed? wg) #false)
