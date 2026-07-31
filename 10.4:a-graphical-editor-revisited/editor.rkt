;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct editor [pre post])
;an Editor is a structure
; (make-editor Lo1S Lo1S)
;a Lo1S is one of:
;-- '()
;-- (cons 1String Lo1S)

(define good (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all (cons "a" (cons "l" (cons "l" '()))))
(define lla (cons "l" (cons "l" (cons "a" '()))))

;data example 1:
(make-editor all good)

;data example 2:
(make-editor lla good)

;Lo1S->Lo1S
;produces a reverse version of the given list
(check-expect (rev all) lla)
(check-expect (rev (cons "h" (cons "e" '()))) (cons "e" (cons "h" '())))
(define (rev l)
  (cond 
    [(empty? l) '()]
    [else (add-at-end(rev (rest l)) (first l))]
  )
)

;Lo1S String->Lo1S
;adds a s to the end of l
(define (add-at-end l s)
  (cond 
    [(empty? l) (cons s '())]
    [else (cons (first l) (add-at-end(rest l) s))]
  )
)
