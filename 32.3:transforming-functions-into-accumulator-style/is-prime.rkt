;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname is-prime) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;N -> Boolean
;returns true if n is prime
(check-expect (is-prime 2) #true)
(check-expect (is-prime 3) #true)
(check-expect (is-prime 4) #false)
(define (is-prime n0)
  (local (;N -> Boolean
          (define (is-prime/a n)
            (cond 
              [(= n 1) #true]
              [(not (= (modulo n0 n) 0)) (is-prime/a (sub1 n))]
              [else #false])))
    (is-prime/a (sub1 n0))))
