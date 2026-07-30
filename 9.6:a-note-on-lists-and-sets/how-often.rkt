;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname how-often) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;List-Of-Strings is one of
;-- '()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings

;List-Of-Strings String -> Number
;counts how many times appears s in l
(check-expect (count (cons "leo" (cons "leo" (cons "leo" (cons "miguel" '())))) "leo" ) 3)
(check-expect (count (cons "julio" (cons "leo" (cons "leo" (cons "miguel" '())))) "leo" ) 2)
(check-expect (count '() "leo" ) 0)
(define (count l s)
  (cond
    [(empty? l) 0]
    [else (cond
        [(string=? (first l) s) (add1 (count (rest l) s))]
        [else (count (rest l) s)]
      )
    ]
  )
)
