;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname table) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct table [legth array])
;a Table is a structure:
;  (make-table N [N -> Number])

(define table1 (make-table 3 (lambda (i) i)))

(define (a2 i) 
  (if (= i 0) 
      pi 
      (error "table2 is not defined for i != 0")))

(define table2 (make-table 1 a2))
