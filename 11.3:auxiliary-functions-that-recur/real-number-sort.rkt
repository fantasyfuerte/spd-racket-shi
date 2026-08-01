;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname real-number-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;List-Of-Numbers->List-Of-Numbers
;produces a sorted version of alon
(check-expect (sort> empty) empty)
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-satisfied  (sort> (list 1 2 3)) sorted>?)
(define (sort> alon)
  (cond
    [(empty? alon) '()]
    [else (insert(first alon)(sort> (rest alon)))]
  )
)

;Number List-Of-Numbers->List-Of-Numbers
;inserts n into the sorted list of numbers alon
(check-expect (insert 2 (list 3 1)) (list 3 2 1))
(check-expect (insert 5 empty) (list 5))
(check-expect (insert 5 (list 3 2 1)) (list 5 3 2 1))
(define (insert n l) 
  (cond
    [(empty? l) (list n)]
    [else 
      (cond
        [(<= (first l) n) (cons n l)] 
        [else (cons (first l) (insert n (rest l)))]
      )]
  )
)

(define (sorted>? l)
  (cond
    [(empty? (rest l)) #true]
    [(>(first(rest l)) (first l)) #false]
    [else (sorted>? (rest l))]
  )
)
