;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname food-create) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define MAX 100)

;Posn -> Posn
;returns a random posn which is guaranteed to be different from p
(define (food-create p)
  (local(
         (define possible (make-posn (random MAX) (random MAX)))
         )
    (if (equal? possible p) (food-create p) possible)))
