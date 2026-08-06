;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fire-fighting-game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

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
