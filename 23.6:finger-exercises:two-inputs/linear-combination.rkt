;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname linear-combination) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Numbers] [List-of Numbers] -> Number
;produces the value of the linear combination
(check-expect (linear-combination '(10 4 6) '(3 3 3)) 60)
(define (linear-combination lc lv)
  (cond
    [(empty? lc) 0]
    [(empty? lv) (error "var not found")]
    [else 
      (+ (* (first lc) (first lv))
        (linear-combination (rest lc) (rest lv)))]))
