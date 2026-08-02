;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname add-polygon-to-scene) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;a Polygon is one of:
;-- (list Posn Posn Posn)
;-- (cons Posn Polygon)

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

;a NELoP is one of:
;-- (cons Posn '())
;-- (cons Posn NELoP)
;interpretation: an arbitrary large non-empty list of points

;Image NELoP -> Image
;connects the dots in p by rendering lines in img 
(check-expect (connect-dots MT triangle-p)
  (scene+line
    (scene+line MT 20 20 30 20 "red")
     20 10 20 20 "red"))
(check-expect (connect-dots MT square-p)
  (scene+line 
    (scene+line
      (scene+line MT 10 10 20 10 "red")
    20 10 20 20 "red")
  20 20 10 20 "red")
)
(define (connect-dots img p)
  (cond 
    [(empty? (rest p)) img]
    [else (render-line (connect-dots img (rest p))(first p) (second p))]
  )
)

;Image Polygon -> Image
;renders the given polygon p in to img
(check-expect (render-poly MT triangle-p)
(scene+line
  (scene+line
    (scene+line MT 20 10 20 20 "red")
    20 20 30 20 "red")
30 20 20 10 "red"))
(check-expect (render-poly MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
      20 10 20 20 "red")
    20 20 10 20 "red")
  10 20 10 10 "red")
)
(define (render-poly img p)
  (render-line (connect-dots img p) (first p) (last p))
)

;Polygon->Posn
;extracts the last posn
(define (last l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (last (rest l))]
  )
)

;Image Posn Posn-> Image
;draws a red line from Posn p to Posn q into img
(define (render-line img p q)
  (scene+line img (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red")
)

(render-poly MT square-p)
(render-poly MT triangle-p)
