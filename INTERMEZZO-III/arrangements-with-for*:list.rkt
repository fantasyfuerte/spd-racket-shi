;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname arrangements-with-for*:list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

;[List-of X] -> [List-of [List-of X]]
;creates a list of all rearrangements of the items in w
(define (arrangements w)
  (cond
    [(empty? w) '(())]
    [else (for*/list ([item w]
                      [arrangement-without-item
                        (arrangements (remove item w))])
             (cons item arrangement-without-item))]))

;[List-of X] -> Boolean
(define (all-words-from-rat? w)
  (and (member? (explode "rat") w)
       (member? (explode "art") w)
       (member? (explode "tar") w)))

(check-satisfied (arrangements (list "r" "a" "t")) all-words-from-rat?)

;[X -> Boolean] [List-of X] -> [X or #false]
;produces the last value who pass the condition, otherwise #false
(define (and-map f l) 
  (for/and ([i l]) (if (f i) i #false))
)
