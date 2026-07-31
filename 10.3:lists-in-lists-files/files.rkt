;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

;a List-Of-Strings is one of:
;--'()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings

(define poem-l (cons "TTT" (cons "" (cons "Put up in a place" (cons "where it's easy to see" '())))))
(define poem-w (cons "TTT" (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '()))))))))))))

;a List-Of-List-Of-Strings (LLS) is one of:
;-- '()
;-- (cons List-Of-Strings List-Of-List-Of-Strings)
;interpretation: an arbitrary large LLS

(define poem-lls (cons (cons "TTT" '()) (cons '() (cons (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '()))))) (cons (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '())))))'()))))) 

;a List-Of-Numbers is one of:
;-- '()
;-- (cons Number List-Of-Numbers)
;interpretation: an arbitrary large list of numbers

(define line1 (cons "Hello" (cons "World" '())))
(define line2 (cons "How" (cons "are" (cons "you" '()))))
(define line3 '())

(define lls1 (cons line1 (cons line2 (cons line3 '()))))
(define lls2 '())

;LLS->List-Of-Numbers
;determines the number of words on each line
(check-expect (words-on-line lls2) '())
(check-expect (words-on-line lls1) (cons 2 (cons 3( cons 0 '()))))
(define (words-on-line lls)
  (cond
    [(empty? lls) '()]
    [else 
    (cons (how-many(first lls)) 
    (words-on-line(rest lls)))
    ]   
  )
)

;List-Of-Strings->Number
;produces the amount of strings of the list
(define (how-many ls)
  (cond
    [(empty? ls) 0]
    [else
    (add1 (how-many (rest ls)))
    ])
)
