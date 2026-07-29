;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname col-and-row) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;an N is one of:
;-- 0
;-- (add1 N)
;interpretation: represent the counting numbers

(define i1 (rectangle 10 10 "solid" "yellow"))

;N Image->Image
;It produces a vertical arrange of N times Image
(check-expect (col 1 i1) i1)
(check-expect (col 3 i1) (above i1 (above i1  i1)))
(define (col n img)
  (cond
    [(= n 1) img]
    [else (above img (col (sub1 n) img))]
  )
)

;N Image->Image
;It produces an horizontal arrange of N times Image
(check-expect (row 1 i1) i1)
(check-expect (row 3 i1) (beside i1 (beside i1  i1)))
(define (row n img)
  (cond
    [(= n 1) img]
    [else (beside img (row (sub1 n) img))]
  )
)

(define seats (overlay(square 20 "outline" "black") (square 20 "solid" "white")))

(define lecture-hall (col 18 (row 8 seats))) 

;a PosnsList is one of
;-- '()
;-- (cons Posn PosnsList)
;interpretation: a list of coordinates

(define balloon-popped (circle 10 "solid" "red"))
(define plist (cons (make-posn 90 200) (cons (make-posn 9 80) (cons (make-posn 28 300) '())))) 

;Image PosnsList->Image
(check-expect (add-balloons lecture-hall '()) lecture-hall)
(check-expect (add-balloons lecture-hall (cons (make-posn 1 4) '()))
  (place-image balloon-popped 1 4 lecture-hall))
(define (add-balloons hall posns)
  (cond
    [(empty? posns) hall]
    [else (place-image balloon-popped (posn-x (first posns)) (posn-y (first posns)) (add-balloons hall (rest posns)))]
  )
)

(add-balloons lecture-hall plist)
