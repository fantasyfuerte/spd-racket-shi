;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-full) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)

(define UFO 
  (overlay/align "center" "bottom"
    (ellipse 90 20 "solid" "green")
    (circle 15 "solid" "seagreen")
  )
)

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

(define HEIGHT 700)
(define WIDTH 500)

(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "black"))


(place-image TANK 40 (- HEIGHT (/ (image-height TANK) 2)) BACKGROUND)
