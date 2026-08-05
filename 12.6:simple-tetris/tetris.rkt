;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname tetris) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define WIDTH 15)
(define HEIGHT 15)
(define SCENE-SIZE (* WIDTH HEIGHT))
(define BLOCK
  (overlay
    (square (- HEIGHT 1) "solid" "red")
    (square HEIGHT "outline" "black")))


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
(define block-dropping (make-block 4 HEIGHT))
(define tetris0 (make-tetris block-dropping landscape0))
(define block-landed (make-block 0 (- HEIGHT 1)))
(define block-on-block (make-block 0 (- HEIGHT 2)))
