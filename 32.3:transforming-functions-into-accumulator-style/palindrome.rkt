;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname palindrome) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of X] -> X
;produces the last element of l
(define (last l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (last (rest l))]
  )
)

(define (all-but-last l)
  (cond
    [(empty? (rest l)) '()]
    [else (cons (first l) (all-but-last (rest l)))]
  )
)

;[NEList-of 1String] -> [NEList-of 1String]
;creates a palindrome from s0
(check-expect
  (mirror (explode "abc")) (explode "abcba"))
(define (mirror s0)
  (append (all-but-last s0)
          (list (last s0))
          (reverse (all-but-last s0))))

(check-expect
  (mirror.v2 (explode "abc")) (explode "abcba"))
(define (mirror.v2 s0)
  (append s0 (rest (reverse s0))))

(check-expect
  (mirror.accu (explode "abc")) (explode "abcba"))
(define (mirror.accu s0)
  (local (;[NEList-of 1String] [List-of 1String] -> [NEList-of 1String]
          ;accumulator a is the 1Strings traversed
          (define (mirror/a s a)
            (cond 
              [(empty? (rest s)) (cons (first s) a)]
              [else (cons 
                      (first s) 
                      (mirror/a (rest s) (cons (first s) a)))])))
    (mirror/a s0 '())))

