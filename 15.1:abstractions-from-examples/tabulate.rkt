;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname tabulate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;Number->[List-of Number]
;tabulates sin between n and 0 (incl.) in a list 
(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else 
      (cons
        (sin n)
        (tab-sin (sub1 n)))
    ]
  )
)

;Number->[List-of Number]
;tabulates sqrt between n and 0 (incl.) in a list
(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else 
      (cons
        (sqrt n)
        (tab-sqrt (sub1 n)))
    ]
  )
)

;Number->[List-of Number]
;tabulates f between n and 0 (incl.) in a list
(define (fold1 f n)
  (cond
    [(= n 0) (list (f 0))]
    [else 
      (cons
        (f n)
        (fold1 f (sub1 n))
      )
    ]
  )
)

;[List-of Number] -> Number
(define (product l)
  (cond
    [(empty? l) 1]
    [else (* (first l) (product (rest l)))]
  )
)

;[List-of Posn]->Image
(define (image* l)
  (cond
    [(empty? l) emt]
    [else (place-dot (first l) (image* (rest l)))]
  )
)

;Posn Image -> Image
(define (place-dot p img)
  (place-image
    dot
    (posn-x p) (posn-y p)
    img))

;graphical constants
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))

(check-expect 
  (fold2 `( ,(make-posn 3 4) ,(make-posn 1 9)) place-dot emt)
  (image* `( ,(make-posn 3 4) ,(make-posn 1 9))))  
(check-expect
  (fold2 '(1 2 4 52 5) * 1)
  (product '(1 2 4 52 5)))
(define (fold2 l f d)
  (cond
    [(empty? l) d]
    [else (f (first l) (fold2 (rest l) f d))]
  )
)
