;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname database) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct db [schema content])
;a DB is a structure: (make-db Schema Content)
;a Schema is a [List-of Spec]
(define-struct spec [label predicate])
;a Spec is a structure:
;  (make-spec (Label Predicate))
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
      (make-spec "Name" string?)
      (make-spec "Age" integer?)
      (make-spec "Present" boolean?)) 
    (list
      (list "Alice" 35 #true)
      (list "Bob" 25 #false)
      (list "Carol" 30 #true)
      (list "Dave" 32 #false))))

(define wrong-db-example-1
  (make-db 
    (list 
      (make-spec "Name" string?)
      (make-spec "Age" integer?))
    (list
      (list "Alice" 35 #true)
      (list "Bob" 25 #false)
      (list "Carol" 30 #true)
      (list "Dave" 32 #false))))

(define db-example-2
  (make-db 
    (list 
      (make-spec "Present" boolean?)
      (make-spec "Description" string?)) 
    (list
      (list #true "presence")
      (list #false "absence"))))

(define wrong-db-example-2
  (make-db 
    (list 
      (make-spec "Present" number?)
      (make-spec "Description" string?)) 
    (list
      (list #true "presence")
      (list #false "absence"))))

;DB -> Boolean
;do all rows in db satisfy (I1) and (I2)
(check-expect (integrity-check db-example-1) #true)
(check-expect (integrity-check db-example-2) #true)
(check-expect (integrity-check wrong-db-example-1) #false)
(check-expect (integrity-check wrong-db-example-2) #false)
(define (integrity-check db)
  (local (
  (define schema (db-schema db))
  (define content (db-content db))
  (define width (length schema))
  ;Row-> Boolean
  ;does row satisfy I1 and I2
  (define (row-integrity-check row) 
    (and (length-of-row-check row)
         (check-every-row row)))
  ;Row -> Boolean
  (define (length-of-row-check r) (= (length r) width))
  ;Row -> Boolean
  (define (check-every-row r) 
    (andmap 
      (lambda (a b) [(spec-predicate a) b])
      schema 
      r))
  )
  (andmap row-integrity-check content)))
