;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname find-name) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)

;String [List-of String] -> [String or #false]
;produces the first name on the list who is n or an extension of n,
;#false otherwise
(define (find-name n l)
  (local (
    ;String -> [String or #false]
    ;produces n if n is in s
    (define (starts-with s)
      (if
        (for/and ([letter n] [letter2 s]) (string=? letter letter2)) 
        s #false)       
    )
  )
  (for/or ([i l]) (starts-with i))) 
) 
