;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname integration-algorithm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)
(define EPSILON 0.1)

(define (constant x) 20)
(define (linear x) (* 2 x))
(define (square x) (* e (sqr x)))
;[Number -> Number] Number Number -> Number
;integrates using kepler's method
;(check-within (integrate-kepler constant 12 22) 200 EPSILON)
;(check-within (integrate-kepler linear 0 10) 100 EPSILON)
;(check-within (integrate-kepler square 0 10)
;              (- (expt 10 3) (expt 0 3)) EPSILON)
(check-within (integrate-kepler (lambda (x) 20) 12 22) 200 EPSILON)
(check-within (integrate-kepler (lambda (x) (* 2 x)) 0 10) 100 EPSILON)
;(check-within (integrate-kepler (lambda (x) (* 3 (sqr x))) 0 10) 1000 EPSILON)
(define (integrate-kepler f a b)
  (local (
          (define mid (/ (+ a b) 2))
          (define at1 (trapezoid-area f a mid))
          (define at2 (trapezoid-area f mid b)))
    (+ at1 at2)))

;[Number -> Number] Number Number -> Number
(define (trapezoid-area f a b)
  (/ (* (- b a) (+ (f a) (f b))) 2))

(define R 30000)

(check-within (integrate-riemann (lambda (x) 20) 12 22) 200 EPSILON)
(check-within (integrate-riemann (lambda (x) (* 2 x)) 0 10) 100 EPSILON)
(check-within (integrate-riemann (lambda (x) (* 3 (sqr x))) 0 10) 1000 EPSILON)
(define (integrate-riemann f a b)
  (local((define width (/ (+ a b) R))
         (define S (/ width 2))
         (define (area-rec i) (* width (f (+ a (* i width) S)))))
    (for/sum ([i (- R 1)])(area-rec i))))
