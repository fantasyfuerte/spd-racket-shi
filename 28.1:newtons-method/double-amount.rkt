;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname double-amount) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Number Percent -> Number
;computes how many months it takes to double a with an interest rate of r
(define (double-amount a r)
  (local (
          (define double (* 2 a))
          (define (helper a n)
            (cond
              [(>= a double) n]
              [else (helper (+ a (* a (/ r 100))) (add1 n))])))
    (helper a 0)))
