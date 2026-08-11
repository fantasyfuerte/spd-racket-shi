;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname found-specification-for-find) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;X [List-of X] -> [Maybe [List-of X]]
;returns the first sublist of l that starts with x, #false otherwise
(define (find x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x) l (find x (rest l)))]))

(define (found x ld)
  (lambda (l)
    (and 
      (or (false? l)(string=? x (first l)))
      (contains? l ld) 
    )))

;[List-of X] [List-of X] -> Boolean
;are all items in list k members of list l
(check-expect (contains? '(1 2 3) '(1 4 3)) #false)
(check-expect (contains? '(1 2 3 4) '(1 3)) #true)
(define (contains? l k)
  (andmap (lambda (in-k) (member? in-k l)) k))
