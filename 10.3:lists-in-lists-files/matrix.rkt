;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname matrix) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;A Matrix is one of:
;-- (cons Row '())
;-- (cons Row Matrix)
;constraint: all rows in matrix are of the same lenght

;A row is one of:
;-- '()
;-- (cons Number Row)

(define row1 (cons 11 ( cons 12 '())))
(define row2 (cons 21 ( cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))

;Matrix->Matrix
;transpose the matrix
(check-expect (transpose mat1) tam1)
(define (transpose lln)
  (cond 
    [(empty? (first lln))'()]
    [else (cons (first* lln) (transpose (rest* lln)))]
  )
) 

;Matrix->Row
;given a matrix returns the first column
(define (first* m)
  (first m)
)

;Matrix->Matrix
(define (rest* m)
  (rest m)
)
