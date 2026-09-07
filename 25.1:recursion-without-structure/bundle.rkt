;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname bundle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of 1String] N -> [List-of String]
;bundles chunks of s into strings of length n
(check-expect (bundle (explode "abcdefg") 3)
              (list "abc" "def" "g"))
(check-expect (bundle (explode "abcdefgh") 2)
              (list "ab" "cd" "ef" "gh"))
(check-expect (bundle (explode "ab") 3)
              (list "ab"))
(check-expect (bundle '() 3) '())
(define (bundle s n) 
  (cond 
    [(empty? s) empty]
    [else (cons (implode(take s n)) (bundle (drop s n) n))]))

;[List-of X] N -> [List-of X]
;keeps the first n items from l if possible or everything
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))

;[List-of X] N -> [List-of X]
;removes the first n items from l if possible or everything
(define (drop l n)
  (cond
    [(zero? n ) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))

;[List-of X] N -> [List-of [List-of X]]
;produces a list of size n chunking the original
(check-expect (list->chunks '(1) 2) '((1)))
(check-expect (list->chunks '(1 2) 2) '((1 2)))
(check-expect (list->chunks '(1 2 3) 2) '((1 2) (3)))
(define (list->chunks l n)
  (cond
    [(empty? l) '()]
    [else (cons (take l n) (list->chunks (drop l n) (sub1 n)))]))
