;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname replace-empty-with-lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

;[List-of Number] [List-of Number] -> [List-of Number]
;replaces the final '() in front with end
(check-expect (replace-eol-with '() '(a b)) '(a b))
(check-expect (replace-eol-with (cons 1 '()) '(a b)) (cons 1 '(a b)))
(define (replace-eol-with front end)
  (cond
    [(empty? front) end]
    [else (cons (first front) (replace-eol-with (rest front) end))]
  )
)

;[List-of Symbol] [List-of Number] -> [List-or [List-of Symbol Number]]
;produces all possible ordered pairs of symbols and numbers
(check-expect 
  (cross '(a b c) '(1 2)) 
  '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))
(define (cross ls ln) (for*/list ([s ls] [n ln])(list s n)))
