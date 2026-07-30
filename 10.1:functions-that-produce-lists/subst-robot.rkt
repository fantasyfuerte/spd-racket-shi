;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname subst-robot) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Toys is one of:
;-- '()
;-- (cons String List-Of-Toys)
;interpretation: an arbitrary large list of strings

;List-Of-Toys->List-Of-Toys
;produces the same list but with "robot" occurrences replaced by "r2d2"
(check-expect (subst (cons "leo" (cons "robot" (cons "robot" empty)))) (cons "leo" (cons "r2d2" (cons "r2d2" empty))))
(define (subst l)
  (cond
    [(empty? l) '()]
    [else (cond
        [(string=? (first l) "robot") (cons "r2d2" (subst (rest l)))]
        [else (cons (first l) (subst(rest l)))]
      )
    ]
  )
)
