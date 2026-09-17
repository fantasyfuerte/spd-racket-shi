;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname big-o-notation (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Exercise 486
;the function f(n) = n^2 + n belongs to the class O(n^2)
;determine the pair of numbers c and bigEnough that verify this claim
;
;if we substitute the values in the definition
;for all n ≥ bigEnough
;it is true that
;f(n) ≤ c * g(n)
;
;we get:
;n^2 + n ≤ c * n^2
;i choose c = 2 then
;n^2 + n ≤ 2n^2 and substracting n^2 we get
;n ≤ n^2 if we choose bigEnough = 1 as the threshold
;so bigEnough = 1
;and c = 2 are a valid pair
;and f(n) belongs to the class O(n^2)

