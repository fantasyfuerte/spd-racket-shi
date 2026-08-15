;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname family-tree) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct child [father mother name date eyes])
;interpretation: (make-child a b c d f) combines the father a,
;the mother b, the name c, the birth date d and the color of eyes f

(define-struct no-parent [])
(define NP (make-no-parent))

;a FT (short for family tree) is one of:
;-- NP
;-- (make-child FT FT String N String)

(define Bettina (make-child NP NP "Bettina" 1926 "green"))
(define Carl (make-child NP NP "Carl" 1926 "green"))

(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))

(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

;FT -> Boolean
;yields true if a family tree has someone with blue eyes
(define (blue-eyed-child? ft)
  (cond
    [(no-parent? ft) #false]
    [else (or (string=? "blue" (child-eyes ft))
              (blue-eyed-child? (child-father ft))
              (blue-eyed-child? (child-mother ft)))]
  )
)

;FT -> Boolean
;yields true if a family tree has someone with blue eyes
(define (count-persons ft)
  (cond
    [(no-parent? ft) 0]
    [else (+ 1
              (count-persons (child-father ft))
              (count-persons (child-mother ft)))]
  )
)

;FT Number -> Number
;produces the average age
(define (average-age ft year)
  (/ (total-age ft year) (count-persons ft))
)

;FT Number -> Number
;produces the sum of all ages of the family tree
(define (total-age ft year)
  (cond
    [(no-parent? ft) 0]
    [else (+ (total-age (child-mother ft) year) 
             (total-age (child-mother ft) year)
             (- year (child-date ft)))]))

;FT -> [List-of String]
;produces a list with the eye colors of the family
(check-expect (eye-colors NP) '())
(check-expect (eye-colors Carl) '("green"))
(check-expect (eye-colors Carl) '("green"))
(define (eye-colors ft)
  (cond 
    [(no-parent? ft) '()]
    [else (cons (child-eyes ft) 
            (append (eye-colors (child-father ft))
                    (eye-colors (child-mother ft))))]
                    
  )
)

;FT -> Boolean
;yields true if a family tree has some ancestor with blue eyes
(check-expect (blue-eyed-ancestor? Gustav) #true)
(check-expect (blue-eyed-ancestor? Eva) #false)
(define (blue-eyed-ancestor? ft)
  (cond
    [(no-parent? ft) #false]
    [else (or (blue-eyed? (child-mother ft))
              (blue-eyed? (child-father ft))
              (blue-eyed-ancestor? (child-father ft))
              (blue-eyed-ancestor? (child-mother ft)))]
  )
)

(define (blue-eyed? ft)
  (cond
    [(no-parent? ft) #false]
    [else (string=? "blue" (child-eyes ft))]
  )
)
