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

;FIRE
(define FIRE 
  (overlay 
    (star-polygon 10 11 3 "solid" "red")
    (star-polygon 15 11 3 "solid" "yellow")
    (star-polygon 20 11 3 "solid" "orange")
  )
)

(define-struct game [plane fires time])
;a Game is a structure:
;(make-game Plane List-Of-Fires Number)
;interpretation: (make-game p f t) combines the plane p
;and the list of fires f and the remaining time t

(define-struct plane [x waters])
;a Plane is a structure:
;(make-plane Number Loads)
;interpretation: (make-plane 40 (make-water 20 '())) means
;that there is a plane at x= 40 who recently hasn't dropped any
;water and has 20 remaining waters

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

;a Game is the state of the world
(define IGS  ;INITIAL GAME STATE
  (make-game
    (make-plane 0 (make-water 50 '()))
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
  (render-fire (game-fires g)
    (render-plane (game-plane g) BACKGROUND)
  )
)

;Plane Image->Image
;renders the plane of the game
(define (render-plane p img) img)

;List-Of-Fires->Image
;renders the fires of the game
(define (render-fire l img) img)

;Game->Game
;changes the game every clock tick
(define (tick-handler g) g)

;Game KeyEvent->Game
;handles key presses
(define (key-handler g ke) g)

;Game->Boolean
;ends the game when the remaining waters are 0 or when the time is 0
(define (end? g) #false)
