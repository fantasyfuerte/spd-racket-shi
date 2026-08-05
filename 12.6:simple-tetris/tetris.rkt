;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname tetris) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define WIDTH 15)
(define HEIGHT 20)
(define SIZE 15)
(define SCENE-SIZE (* WIDTH SIZE))
(define MT (empty-scene (* WIDTH SIZE) (* HEIGHT SIZE)))
(define BLOCK
  (overlay
    (square (- SIZE 1) "solid" "red")
    (square SIZE "outline" "black")))


(define-struct tetris [block landscape])
(define-struct block [x y])

;a Tetris is a structure:
;(make-tetris Block Landscape)
;interpretation: (make b l) combines
;the dropping block b and the list of
;resting blocks l 

;a Landscape is one of:
;-- '()
;-- (cons Block Landscape)
;interpretation: an arbitrary large list
;of resting blocks

;a Block is a structure
;(make-block N N)
;interpretation: (make-block x y) means a block
;located at (x (- HEIGHT y))

(define landscape0 empty)
(define block-dropping (make-block 4 0))
(define tetris0 (make-tetris block-dropping landscape0))
(define block-landed (make-block 0 (- HEIGHT 1)))
(define block-on-block (make-block 0 (- HEIGHT 2)))

;Any->Tetris
(define (main x)
  (big-bang (make-tetris (make-block (random WIDTH) 0) '())
    [to-draw render-tetris] 
    [on-key key-handler] 
    [on-tick tick-tetris 1] 
    [stop-when full?]
  )
)

;Tetris->Image
;renders the tetris
(define (render-tetris t) MT) 

;Tetris KeyEvent->Tetris
;controlls the dropping block
(define (key-handler t ke) t)

;Tetris->Tetris
;changes the position of the game every second
(define (tick-tetris t) t)

;Tetris->Boolean
;yields true if the new resting block is at y = HEIGHT
(define (full? t) #false)
