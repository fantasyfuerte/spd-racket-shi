;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname add3-to-all) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Posn] -> [List-of Posn]
;adds 3 to each x-coordinate on the given list
(check-expect
  (add-3-to-all
    (list (make-posn 3 1) (make-posn 0 0)))
  (list (make-posn 6 1) (make-posn 3 0)))
(define (add-3-to-all lop)
  (cond
    [(empty? lop) '()]
    [else (cons 
      (make-posn (+ 3 (posn-x (first lop))) (posn-y (first lop)))
      (add-3-to-all (rest lop)))]
  )
)
