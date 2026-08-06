;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-full) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

;UFO
(define UFO 
  (overlay/align "center" "bottom"
    (ellipse 90 20 "solid" "green")
    (circle 15 "solid" "seagreen")
  )
)

;TANK
(define TANK
  (above
    (above/align "center"
      (above
        (rectangle 12 12 "solid" "grey")
        (rectangle 10 30 "solid" "forestgreen")
      )
      (rectangle 90 30 "solid" "forestgreen")
    )
    (beside
      (rectangle 10 15 "solid" "dimgray")
      (rectangle 50 15 "solid" "black")
      (rectangle 10 15 "solid" "dimgray")
    )
  )
)
(define TANK-VEL 5)
(define Y-TANK (- HEIGHT (/ (image-height TANK) 2)))

;SCENE
(define HEIGHT 700)
(define WIDTH 500)
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "black"))

(define-struct game [ufo tank])
;a SIGS is a structure:
;(make-game UFO Tank)
;interpretation: (make-game u t) combines the tank and the ufo
;in one state

;a Direction is one of:
;-- "left"
;-- "right"

(define-struct ufo [pos dir vel shots])
;an UFO is a structure:
;(make-ufo Posn Direction Number Lists-Of-Shots)
;interpretation: (make-ufo (make-posn 40 8) "left" 2 '()) means
;that an ufo ,which is 40px from the left margin an 8px from the top
;margin, is moving to the left at 2px per tick and has'nt fired any 
;shots yet

(define-struct tank [x dir shots])
;a Tank is a structure:
;(make-tank Number List-Of-Shots)
;interpretation: (make-tank 5 "right" '()) represents a tank in x=5,
;moving to the right, who haven't fired any shots
