;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname accu-map) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[X -> Y] [List-of X] -> [List-of Y]
;produces a new list with f applied to every element of l
(check-expect (accu-map (lambda (x) x) '(1 2 3)) '(1 2 3))
(check-expect (accu-map (lambda (x) (sqr x)) '(1 2 3)) '(1 4 9))
(define (accu-map f l0)
  (local (;[List-of X] [List-of Y] -> [List-of Y]
          ;produces a new list with f applied to every element of l
          ;accumulator a is the list so far
          (define (map/a l a)
            (cond
              [(empty? l) a]
              [else (map/a (rest l) (cons (f (first l)) a))])))
    (map/a (reverse l0) '())))
