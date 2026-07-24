;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname compare-word) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct word [one two three])

;a Letter is a 1String or #false

;a Word is a structure that represents a three letter word
;(make-word Letter Letter Letter)
;(make-word "i" "c" "e") means "ice"

(define w1 (make-word "i" "c" "e"))
(define w2 (make-word "a" "c" "e"))
(define w3 (make-word "i" "c" "e"))
(define w4 (make-word "l" "e" "o"))

;Word Word->Word
;Returns a Word with #false when the letters doesn't match and with the letter when its match 
(check-expect (compare-words w1 w2) (make-word #false "c" "e"))
(check-expect (compare-words w1 w3) (make-word "i" "c" "e"))
(check-expect (compare-words w1 w4) (make-word #false  #false #false))
(define (compare-words w1 w2)
  (make-word 
    (if(string=? (word-one w1)(word-one w2)) (word-one w1) #false)
    (if(string=? (word-two w1)(word-two w2)) (word-two w1) #false)
    (if(string=? (word-three w1)(word-three w2)) (word-three w1) #false)
  )
)
