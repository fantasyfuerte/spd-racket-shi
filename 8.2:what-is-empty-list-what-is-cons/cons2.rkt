;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cons2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct pair [left right])
;a ConsPair is a structure
;(make-pair(Any Any)

;ConsOrEmpty is one of:
;-- '()
;-- (make-pair Any ConsOrEmpty

;Any Any-> ConsOrEmpty
(define (cons2 v l)
  (cond
    [(or(empty? l)(pair? l))(make-pair v l)]
    [else (error "cons2: second argument is not a list")]
  )
)

;ConsOrEmpty->Any
(define (first2 c)
  (pair-left c)
)

;ConsOrEmpty->ConsOrEmpty
(define (rest2 c)
  (pair-right c)
)

(define nl (cons2 "leo" (cons2 "leito" '())))


