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

;[Number Number] [List-of Number] Number [Number Number -> Number] -> Number
(define (pr* l bs jn)
  (cond
    [(empty? l) bs]
    [else
      (jn (first l)
        (pr* (rest l) bs jn)
      )
    ]
  )
)

;[Posn Image] [List-of Posn] Image [Posn Image -> Image] -> Image
(define (im* l bs jn)
  (cond
    [(empty? l) bs]
    [else
      (jn (first l)
        (im* (rest l) bs jn)
      )
    ]
  )
)

;[X Y] [List-of X] Y [X Y -> Y] -> Y
(define (a* l bs jn)
  (cond
    [(empty? l) bs]
    [else
      (jn (first l)
        (a* (rest l) bs jn)
      )
    ]
  )
)

;[Number -> Boolean]
(define (even* n)
  (= (modulo n 2) 0)
)

;[Boolean String -> Boolean]
(define (cocaine b s) b)

;[Number Number Number -> Number]
(define (sum3 n n1 n2) (+ n n1 n2))

;[Number -> [List-of Number]]
(define (do-list n) (list n))

;[[List-of Number] -> Boolean]
(define (length>5 l) (> (length l) 5))

;[[List-of Numbers] [Number Number -> Boolean] -> [List-of Numbers]]

;[[List-of String] [String String -> Boolean] -> [List-of String]]

;[X] [[List-of X] [X X -> Boolean] -> [List-of X]]

;[[List-of IR] [IR IR -> Boolean] -> [List-of IR]]
