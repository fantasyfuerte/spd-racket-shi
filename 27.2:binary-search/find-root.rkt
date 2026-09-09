;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname find-root) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define EPSILON 0.001)

;[Number -> Number] Number Number -> Numer
;determines R such that f has a root in [R ,(+ R EPSILON)]
;assume: f is continuous
;(2) (or (<- (f left) 0 (f right)) (<= (f right) 0 (f left)))
;generative: divides interval in half, the root is in one of the 
;halves, picks according to (2)
(check-satisfied 
  (find-root poly 3 6) 
  (lambda (n) 
    (zero? (poly(round n)))))
(define (find-root f left right)
  (cond
    [(<= (- right left) EPSILON) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@m (f mid))
              (define fl (f left))
              (define fr (f right)))
              (cond
                [(or (<= fl 0 f@m) (<= f@m 0 fl))
                 (find-root f left mid)]
                [(or (<= f@m 0 fr) (<= fr 0 f@m))
                 (find-root f mid right)]))]))

;Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))
