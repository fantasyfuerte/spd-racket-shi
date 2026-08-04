;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname worms-game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define APPLE (circle 5 "solid" "red"))
(define BODY (circle 10 "solid" "yellow"))
(define HEAD (circle 13 "solid" "orange"))

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
