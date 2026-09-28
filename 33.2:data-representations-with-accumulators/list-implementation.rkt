;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname list-implementation) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct pair [left right])
;ConsOrEmpty is one of:
; -- '()
; -- (make-pair Any ConsOrEmpty)

;Any -> boolean
(define (our-cons? x) (pair? x))

;Any ConsOrEmpty -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(our-cons? a-list) (make-pair a-value a-list)]
    [else (error "Not a list")]))

;ConsOrEmpty -> Any
;extracts the left part of the given pair
(define (our-first mimicked-list)
  (if (empty? mimicked-list)
      (error "List is empty")
      (pair-left mimicked-list)))

;ConsOrEmpty -> ConsOrEmpty
;retrieves the rest of the list
(define (our-rest a-list)
  (cond
    [(empty? a-list) (error "List is empty")]
    [else (pair-right a-list)]))
