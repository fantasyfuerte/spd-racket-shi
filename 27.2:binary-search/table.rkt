;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname table) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct table [length array])
;a Table is a structure:
;  (make-table N [N -> Number])

(define table1 (make-table 3 (lambda (i) i)))

(define (a2 i) 
  (if (= i 0) 
      pi 
      (error "table2 is not defined for i != 0")))

(define table2 (make-table 1 a2))

(define l1 '(-2 -1 0 1 2))
(define table3 (make-table 5 (lambda (x) (list-ref l1 x))))

;Table N -> Number
;looks up the ith value in array of t
(define (table-ref t i)
  ((table-array t) i))

;Table -> Number
;finds the smalles index for a root of the table
;constraint: t is a monotonically increasing table
(check-expect (find-linear table1) 0)
(check-error (find-linear table2) "limit reached")
(check-expect (find-linear table3) 2)
(define (find-linear t)
  (local(
         (define length (table-length t))
         (define (maptable i)
           (if (= i length)
               (error "limit reached")
               (if (zero? (table-ref t i)) 
                   i
                   (maptable (add1 i))))))
    (maptable 0)))

;Table -> Number
;finds the smalles index for a root of the table
;constraint: t is a monotonically increasing table
(check-expect (find-binary table1) 0)
(check-error (find-binary table2) "not found")
(check-expect (find-binary table3) 2)
(define (find-binary t)
  (local(
         (define (binary-search left right)
           (cond
             [(= left right) (if (zero? (table-ref t left))
                                 left
                                 (error "not found"))]
             [else (local ((define mid (floor(/ (+ left right) 2))))
                     (cond 
                       [(< 0 (table-ref t mid)) (binary-search left mid)]
                       [(> 0 (table-ref t mid)) (binary-search mid right)]
                       [else mid]))])))
         (binary-search 0 (table-length t))))
