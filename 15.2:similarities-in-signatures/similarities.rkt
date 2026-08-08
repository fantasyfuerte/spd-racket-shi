;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname similarities) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[X Y] [List-of X] [X->Y] -> [List-of Y]
(define (map* l f)
  (cond
    [(empty? l) '()]
    [else 
      (cons
        (f (first l))
        (map* (rest l) f))
    ]
  )
)
