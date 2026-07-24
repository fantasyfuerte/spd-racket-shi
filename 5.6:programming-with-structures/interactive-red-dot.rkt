;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname interactive-red-dot) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

;a Posn represents the state of the world

;Posn->Posn
(define (main p0) 
  (big-bang p0
  [on-tick x+]
  [on-mouse reset-dot]
  [to-draw scene+dot]
  [stop-when stop-handler]
  )
)

;Posn->Image
;adds a red dot to MTS at p
(check-expect (scene+dot (make-posn 10 20))(place-image DOT 10 20 MTS)) 
(check-expect (scene+dot (make-posn 88 73))(place-image DOT 88 73 MTS))

(define (scene+dot p) 
  (place-image DOT (posn-x p) (posn-y p) MTS)
)

;Posn->Posn
;increments the x coordinate by 3
(check-expect (x+ (make-posn 3 4)) (make-posn 6 4))
(check-expect (x+ (make-posn 8 0)) (make-posn 11 0))
(define (x+ p)
  (make-posn (+ 3 (posn-x p)) (posn-y p) )
)

;Posn X-Mouse Y-Mouse MouseEvent->Posn
;resets the dot to the mouse coordinates
(check-expect (reset-dot (make-posn 10 20) 29 31 "button-down") (make-posn 29 31))
(check-expect (reset-dot (make-posn 0 20) 2 3 "button-down") (make-posn 2 3))
(define (reset-dot p x y me)
  (if(string=? me "button-down")(make-posn x y)p)
)

;Posn->Boolean
;Stop the big-bang when the dot is out of sight
(define (stop-handler s) 
  (if(> (posn-x s) (image-width MTS)) #true #false)
)


(main (make-posn 0 20))
