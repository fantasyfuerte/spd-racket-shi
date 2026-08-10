;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname append-from-fold) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of X] [List-of X] -> [List-of X]
;concatenates two lists
(define (append-from-fold l1 l2)
  (local(
    (define (f a b)
      (cons a b)
    )) 
  (foldr f l2 l1)
  )
)
