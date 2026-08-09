;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname drawing-polygons-with-local-definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define triangle-p
  (list 
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 30 20)))

(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))

;a plain background image
(define MT (empty-scene 50 50))

;Image Polygon -> Image
;renders the given polygon p in to img
(check-expect (render-polygon MT triangle-p)
(scene+line
  (scene+line
    (scene+line MT 20 10 20 20 "red")
    20 20 30 20 "red")
30 20 20 10 "red"))
(check-expect (render-polygon MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
      20 10 20 20 "red")
    20 20 10 20 "red")
  10 20 10 10 "red")
)
(define (render-polygon img p)
  (local(
  ;NELoP -> Image
  (define (connect-dots p)
    (cond
      [(empty? (rest p)) img]
      [else (render-line (connect-dots (rest p))
                         (first p)
                         (second p))]
    )
  )
  (define connected-dots (connect-dots p)) 
  (define last-point (last p))
  (define polygon (render-line connected-dots (first p) last-point))
  )
  polygon) 
)

;Image Posn Posn -> Image
(define (render-line im p q)
  (scene+line
    im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))

;Polygon -> Posn
;extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]
  )
)
