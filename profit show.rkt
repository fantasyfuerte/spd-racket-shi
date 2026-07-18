;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Untitled) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (attendance price)
  (- 120 (* (- price 5) (/ 15 0.1))))

(define (revenue price)
  (* price (attendance price)))

(define (cost price)
  (* (attendance price) 1.5))
  
 (define (profit price)
  (- (revenue price) (cost price)))


 (profit 2)
 (profit 3.65)
