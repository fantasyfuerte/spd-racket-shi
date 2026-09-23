;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname matrix) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Matrix -> Matrix
;finds a row that doesn't start with 0 and
;uses it as the first one
;generative: moves the first row to last place
;no termination: if all rows start with 0
(check-expect (rotate '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))
(define (rotate M)
  (cond 
    [(not (= (first (first M)) 0)) M]
    [else 
      (rotate (append (rest M) (list (first M))))]))

(check-expect (rotate.accu '((0 4 5) (1 2 3)))
              '((1 2 3) (0 4 5)))
(check-error (rotate.accu '((0 4 5) (0 2 3) (0 0 0)))
             "matrix is not invertible")
(define (rotate.accu M0)
  (local (;Matrix Matrix -> Matrix
          ;finds a row that doesn't start with 0 and
          ;uses it as the first one
          ;accumulator seen is the rows that have been seen
          (define (rotate/a M seen)
            (cond 
              [(empty? M) (error "matrix is not invertible")]
              [(not (= (first (first M)) 0)) (append M (reverse seen))]
              [else 
                (rotate/a (rest M) 
                          (cons (first M) seen))])))
    (rotate/a M0 '())))

