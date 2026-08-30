;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname DNAprefix) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a DNA-Symbol if one of:
;-- 'a
;-- 'c
;-- 'g
;-- 't

;[List-of DNA-Symbol] [List-of DNA-Symbol] -> Boolean
;yields true if ss is a prefix in p
(check-expect (dna-prefix '(a c g t t) '(a c)) #true)
(check-expect (dna-prefix '(a c g t t) '(a g)) #false)
(define (dna-prefix p ss)
  (cond
    [(empty? ss) #true]
    [(empty? p) #false]
    [else (if (symbol=? (first p) (first ss)) 
              (dna-prefix (rest p) (rest ss))
              #false)]
  )
)
