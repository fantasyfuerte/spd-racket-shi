;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname controllable-dot) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define DOT (circle 10 'solid 'red))
(define BACKGROUND (empty-scene 300 200))
(define Y-DOT 50)

;State: Number that represents distance from the background's left margin

(define (main x)
  (big-bang x
    [to-draw render]
    [on-key key-handler]
    ))

;State->Image
;Given a x returns an image with a dot placed x pixels from the left margin
(define (render x)
  (place-image DOT x Y-DOT BACKGROUND))

;State KeyboardEvent->State
;If the ke is "left" decrements from state, if is "right" increments state
;given: 10 "right" expects: 13
;given: 10 "left" expects: 7
(define (key-handler s ke)
  (cond
      [(string=? ke "left")(if(>= s 0)(- s 3)s)]
      [(string=? ke "right")(if(<= s (image-width BACKGROUND))(+ s 3)s)]
      [else s]
      ))
(check-expect (key-handler 10 "right") 13)
(check-expect (key-handler 10 "left") 7)
(main 0)
"hello from vim"
