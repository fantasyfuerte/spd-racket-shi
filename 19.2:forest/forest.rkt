;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname forest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct child [father mother name date eyes])
;interpretation: (make-child a b c d f) combines the father a,
;the mother b, the name c, the birth date d and the color of eyes f

(define-struct no-parent [])
(define NP (make-no-parent))

;a FT (short for family tree) is one of:
;-- NP
;-- (make-child FT FT String N String)

;family trees
;older
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
(define Carl (make-child NP NP "Carl" 1926 "green"))

;middle
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))

;younger
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))


;family forest 
(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))

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

;[List-of FT] -> Boolean
;does the forest contain any child with "blue" eyes
(check-expect (blue-eyed-child-in-forest? ff1) #false)
(check-expect (blue-eyed-child-in-forest? ff2) #true)
(check-expect (blue-eyed-child-in-forest? ff3) #true)
(define (blue-eyed-child-in-forest? f)
  (ormap blue-eyed-child? f)
)
