;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname add-to-pi) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;N -> Number
;adds n to pi without using +
(check-within (add-to-pi 2) (+ 2 pi) 0.001)
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (add1 (add-to-pi (sub1 n)))]))

;N -> Number
;adds n to pi without using +
(define (add-to-pi.accu n0)
  (local (;N Number -> Number
          ;produces the sum of pi and n))
          (define (add/a n a)
            (cond
              [(zero? n) a]
              [else (add/a (sub1 n) (add1 a))])))
    (add/a n0 0)))
