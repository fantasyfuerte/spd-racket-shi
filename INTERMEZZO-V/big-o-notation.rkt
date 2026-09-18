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

;Exercise 487
;f(n) = 2^n
;g(n) = 1000n
;in this case we could choose c= 1000 and n0 = 1
;or we could also choose c = 1 and n0 = 14 this give us a hint that
;f belongs to O(2^n) with c = 1 only for n ≥ 14
;so that means that in the interval [3, 12] the best function is f

;Exercise 488
;f(n) = n log n
;g(n) = n^2 
;Does f belong to O(g) or g to O(f)?
;If we use the definition above we get
;n log n ≤ n^2 * c and if we divide by n we get:
;log n ≤ n * c 
;if n0 = 0
;this holds for all n ≥ n0 so that means that f belongs to O(g)
;and the contant c = 1 of course
