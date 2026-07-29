;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname how-many-strings) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define l (cons "uno" (cons "Leo" (cons "Miguel" (cons "Roberto" (cons "Perro" (cons "macbook" '())))))))

;a List-Of-Strings is one of:
;-- '()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of words


;List-Of-Strings->Number
;Given a List-Of-Strings returns how many string it has
(check-expect (how-many l) 6)
(check-expect (how-many (cons "Leo" '())) 1)
(check-expect (how-many '()) 0)
(define (how-many l)
  (cond
    [(empty? l) 0]
    [else (add1 (how-many(rest l)))]
  )
)

