;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname database) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct db [schema content])
;a DB is a structure: (make-db Schema Content)
;a Schema is a [List-of Spec]
;a Spec is a [List-of Label Predicate
;a Label is a String
;a Predicate is a [Any -> Boolean]

;a (piece of) Content is a [List-of Row]
;a Row is a [List-of Cell]
;a Cell is Any
;constraint cells do not contain functions

;integrity constraint In (make-db sch con),
;for every row in con,
;(I1) its length is the same as sch's, and
;(I2) its ith Cell satisfies the ith Predicate in sch 

(define db-example-1
  (make-db 
    (list 
      (list "Name" string?) 
      (list "Age" number?) 
      (list "Present" boolean?))
    (list
      (list "Alice" 35 #true)
      (list "Bob" 25 #false)
      (list "Carol" 30 #true)
      (list "Dave" 32 #false))))

(define db-example-2
  (make-db 
    (list 
      (list "Present" boolean?)
      (list "Description" string?)) 
    (list
      (list #true "presence")
      (list #false "absence"))))
