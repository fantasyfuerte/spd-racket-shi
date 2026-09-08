;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname greatest-common-divisor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;N[>=1] N[>=1] -> N
;computes the greatest common divisor of n and m
(check-expect (gcd-structural 12 18) 6)
(check-expect (gcd-structural 6 25) 1)
(define (gcd-structural n m)
  (local(
         (define (greatest-divisor-<= i)
           (cond
             [(= i 1) 1]
             [else 
               (if (= (remainder n i) (remainder m i) 0)
                   i
                   (greatest-divisor-<= (- i 1)))])))
    (greatest-divisor-<= (min n m))))

;Question: How does this function work?
;Answer: Uses the fact that the greatest divisor of the two numbers is 
;less that or equal to the smaller of the two numbers. It starts with
;the smaller number and keeps decrementing until a match is found. 

;N[>=1] N[>=1] -> N
;computes the greatest common divisor of n and m
(define (gcd-generative n m)
  (local(
         (define (clever-gcd L S)
           (cond
             [(= S 0) L]
             [else (clever-gcd S (remainder L S))])))
    (clever-gcd (max m n) (min m n))))
