;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname to10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Number] -> Number
;consumes the digits and produces the corresponding number
(check-expect (to10 '(1 2 3 4 5)) 12345)
(define (to10 l)
  (local (;[List-of Number] Number -> Number
          ;produces the corresponding number
          ;accumulator n is the ordinal
          (define (to10/a l n)
            (cond
              [(empty? l) 0]
              [else (+ (* (first l) (expt 10 n)) 
                       (to10/a (rest l) (add1 n)))])))
    (to10/a (reverse l) 0)))
