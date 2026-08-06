;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname tetris) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define WIDTH 10)
(define HEIGHT 10)
(define SIZE 50)
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

;Number->Tetris
(define (main x)
  (big-bang (make-tetris (make-block (random WIDTH) 0) '())
    [to-draw render-tetris] 
    [on-key key-handler] 
    [on-tick tick-tetris x] 
    [stop-when full?]
  )
)

;Tetris->Image
;renders the tetris
(define (render-tetris t)
  (render-dropping (tetris-block t)
    (render-landscape (tetris-landscape t) MT)
  )
)

;Block Image->Image
;renders the dropping block into img
(define (render-dropping b img)
  (place-image BLOCK (* SIZE (block-x b)) (* SIZE (block-y b)) img)
)

;Landscape Image->Image
;renders the resting blocks into img
(define (render-landscape l img) 
  (cond
    [(empty? l) img]
    [else 
      (place-image 
        BLOCK 
        (* SIZE (block-x (first l)))
        (* SIZE (block-y (first l))) 
        (render-landscape (rest l) img)
      )
    ]
  )
)

;Tetris KeyEvent->Tetris
;controlls the dropping block
(define (key-handler t ke)
  (cond
    [(string=? ke "right") (move-right t)]
    [(string=? ke "left") (move-left t)]
    [else t]
  )
)

;Tetris->Tetris
;moves the dropping block to the right
(define (move-right t) t)

;Tetris->Tetris
;moves the dropping block to the left
(define (move-left t) t)

;Tetris->Tetris
;changes the position of the game every second
(define (tick-tetris t)
  (cond
    [(has-landed? t) (add-new t)]
    [else (make-tetris (increment (tetris-block t)) (tetris-landscape t))]
  )
)

;Tetris->Boolean
;yields true if the block has landed
(define (has-landed? t)
  (or
    (= (- HEIGHT 1) (block-y (tetris-block t))) 
    (landed-on-block? (tetris-block t) (tetris-landscape t))
  )
)

;Block Landscape->Boolean
;yields true if the block landed on another block
(define (landed-on-block? b l)
  (cond
    [(empty? l) #false]
    [else 
      (cond
        [(and (= (block-x b) (block-x (first l)))
              (= (add1 (block-y b)) (block-y (first l)))
         ) #true]
        [else (landed-on-block? b (rest l))]
      )
    ]
  )
)

;Tetris->Tetris
;add a new block to the game
(define (add-new t)
  (make-tetris 
    (make-block (random WIDTH) 0) 
    (cons (tetris-block t) (tetris-landscape t)))
)

;Block->Block
;increments the y position of the block
(define (increment b)
  (make-block (block-x b) (add1 (block-y b)))
)

;Tetris->Boolean
;yields true if the new resting block is at y = HEIGHT
(define (full? t) #false)

(main 0.1)
