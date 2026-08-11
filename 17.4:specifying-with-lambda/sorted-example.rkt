;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname sorted-example) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[X] [List-of X] [X X -> Boolean] -> [List-of X]
;sorts l according to cmp
(check-expect (sort-cmp '("c" "b") string<?) '("b" "c"))
(check-expect (sort-cmp '(2 1 3 4 6 5) <) '(1 2 3 4 5 6))
(check-satisfied (sort-cmp '("c" "b") string<?)
                 (sorted string<?))
(check-satisfied (sort-cmp '(2 1 3 4 6 5) <)
                 (sorted <))
(define (sort-cmp l cmp)
  (local (
    ;[List-of X] -> [List-of X]
    ;produces a variant of l sorted by cmp
    (define (isort l)
      (cond
        [(empty? l) '()]
        [else (insert (first l) (isort (rest l)))]
      )
    )
    
    ;X [List-of X] -> [List-of X]
    ;inserts n into the sorted list of numbers
    (define (insert n l)
      (cond
        [(empty? l) (cons n '())]
        [else (if (cmp n (first l))
                  (cons n l)
                  (cons (first l) (insert n (rest l))))])))
  (isort l)))

;[X X -> Boolean] -> [ [List-of X] -> Boolean]
;produces a function that determines wheter some list is sorted
;according to cmp
(check-expect [(sorted string<?) '("b" "c")] #true)
(check-expect [(sorted <) '(1 2 3 4 5)] #true)
(define (sorted cmp)
  (lambda (l)
    (sorted? cmp l)))

;[X X -> Boolean] [NEList-of X] -> Boolean
;determines whether l is osrted according to cmp 
(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(5 2 3)) #false)
(define (sorted? cmp l)
  (cond
    [(or (empty? l) (empty? (rest l))) #true]
    [else (and (cmp (first l) (second l))
               (sorted? cmp (rest l)))]
  )
)

(check-expect [(sorted-variant-of '(3 2) <) '(2 3)] #true)
(check-expect [(sorted-variant-of '(3 2) <) '(3)] #false)
(define (sorted-variant-of k cmp)
  (lambda (l)
    (and (sorted? cmp l)
         (contains? l k))))

;[List-of X] [List-of X] -> Boolean
;are all items in list k members of list l
(check-expect (contains? '(1 2 3) '(1 4 3)) #false)
(check-expect (contains? '(1 2 3 4) '(1 3)) #true)
(define (contains? l k)
  (andmap (lambda (in-k) (member? in-k l)) k))
