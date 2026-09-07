;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname quick-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Number]-> [List-of Number]
;produces a sorted version of l
(check-expect (quick-sort< '(1 2 3 4 5)) '(1 2 3 4 5))
(check-expect (quick-sort< '(5 3 2 4 1)) '(1 2 3 4 5))
(define (quick-sort< l)
  (cond
    [(empty? l) '()]
    [else (local (
            (define smallers (quick-sort< 
                    (filter 
                      (lambda (x) (< x (first l))) 
                      (rest l))))
            (define largers (quick-sort< 
                          (filter 
                            (lambda (x) (>= x (first l))) 
                            (rest l)))))
            (append smallers
                  (cons (first l) 
                        largers)))]))
