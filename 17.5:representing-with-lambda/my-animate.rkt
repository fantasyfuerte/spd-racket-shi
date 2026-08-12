;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname my-animate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

;an ImageStream is a function
;[N -> Image]
;interpretation: a stream s denotes a series of images

(define ROCKET 
  (above 
    (triangle 15 'solid 'red) 
    (overlay
      (rectangle 15 50 'solid 'skyblue)
      (triangle 30 'solid 'red))))

;ImageStream
(define (create-rocket-scene height)
  (place-image ROCKET 50 height (empty-scene 200 200)))

(animate create-rocket-scene)

(define (my-animate s n)
  (big-bang 0
    [to-draw s] 
    [on-tick add1]
  )
)
