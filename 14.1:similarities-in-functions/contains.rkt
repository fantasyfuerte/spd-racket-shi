;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname contains) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;List-Of-Strings String->Boolean
;yields true if s is in los
(define (contains? los s)
  (cond
    [(empty? los) #false]
    [else (or (string=? s (first los))
              (contains? s (rest los)))
    ]
  )
)

;List-Of-Strings->Boolean
;yields true if "atom" is in los
(define (contains-atom? l)
  (contains? l "atom")
)

;List-Of-Strings->Boolean
;yields true if "basic" is in los
(define (contains-basic? l)
  (contains? l "basic")
)

;List-Of-Strings->Boolean
;yields true if "zoo" is in los
(define (contains-zoo? l)
  (contains? l "zoo")
)
