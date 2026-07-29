;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname copier) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;an N is one of:
;-- 0
;-- (add1 N)
;interpretation: represent the counting numbers

;a List-Of-Strings is one of:
;-- '()
;-- (cons String List-Of-Strings)

;N String->List-Of-Strings
;makes a list of v n times
(check-expect (copier 1 "a") (cons "a" '()))
(check-expect (copier 3 "b") (cons "b"(cons "b" (cons "b" '()))))
(define (copier n v)
  (cond
    [(zero? n) '()]
    [else (cons v (copier (sub1 n) v))]
  )
)
