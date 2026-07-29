;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname contains-flat) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define example-list (cons "Leo" (cons "Mauro" (cons "Flat" '()))))

;ListOfNames->Boolean
;Checks if name is a member of list l
(define (contains l name)
  (cond
    [(empty? l) #false]
    [(string=? (first l) name) #true]
    [else (contains (rest l) name)]
  )
)

(contains example-list "Leo")
(contains example-list "Flat")
(contains example-list "nnn")
