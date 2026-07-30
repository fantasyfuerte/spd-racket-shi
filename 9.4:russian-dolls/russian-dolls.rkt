;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname russian-dolls) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct layer [color doll])

;an RD (short for Russian Doll) is one of:
;-- String
;-- (make-layer String RD)

(define example-rds (make-layer "pink" (make-layer "black" "white")))

;RD->Number
;produces the amount of dolls from a rd
(check-expect (depth "red") 1)
(check-expect (depth example-rds) 3)
(define (depth rd)
  (cond
    [(string? rd) 1]
    [else (add1 (depth (layer-doll rd)))]
  )
)

;RD->String
;produces the innermost color of an RD
(check-expect (inner "red") "red")
(check-expect (inner example-rds) "white")
(define (inner rd)
  (cond
    [(string? rd) rd]
    [else (inner (layer-doll rd))]
  )
)
