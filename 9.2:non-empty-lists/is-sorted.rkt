;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname is-sorted) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a NEList-Of-Temperatures is one of:
;-- (cons CTemperature '())
;-- (cons CTemperature NEList-Of-Temperatures)
;interpretation: an arbitrary large list of temperatures

;a CTemperature is a Number greater than -272

;NEList-Of-Temperatures->Boolean
;yields #true if the list is sorted
(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
(check-expect (sorted>? (cons 4 (cons 2 '()))) #true)
(check-expect (sorted>? (cons 4 '())) #true)
(define (sorted>? l)
  (cond
    [(empty? (rest l)) #true]
    [(>(first(rest l)) (first l)) #false]
    [else (sorted>? (rest l))]
  )
)
