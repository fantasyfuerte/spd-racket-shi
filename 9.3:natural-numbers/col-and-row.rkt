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
