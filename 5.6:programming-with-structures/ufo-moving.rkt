;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ufo-moving) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct ufo [loc vel])
;an UFO is a structure
; (make-ufo Posn Vel)
; (make ufo p v) is at location p moving at velocity v

(define-struct vel [dx dy])
;a Vel is a structure
; (make-vel Number Number)
; (make-vel dx dy) has moved dx dy

(define v1 (make-vel 8 -3)) 
(define v2 (make-vel -5 -3)) 

(define p1 (make-posn 22 80)) 
(define p2 (make-posn 30 77)) 

(define u1 (make-ufo p1 v1)) 
(define u2 (make-ufo p1 v2)) 
(define u3 (make-ufo p2 v1)) 
(define u4 (make-ufo p2 v2))

;UFO->UFO
;computes the ufo location on the next clock-tick
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2) (make-ufo (make-posn 17 77) v2))
(define (ufo-move-1 u)
  (make-ufo 
    (make-posn 
      (+ (vel-dx (ufo-vel u)) (posn-x (ufo-loc u))) 
      (+ (vel-dy (ufo-vel u)) (posn-y (ufo-loc u)))
    )
    (ufo-vel u)
  )
)
