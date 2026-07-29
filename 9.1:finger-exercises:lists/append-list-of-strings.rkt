;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname append-list-of-strings) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Strings is one of:
;-- '()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings


;List-Of-Strings->String
;returns one big string with all the strings of the list
(check-expect (cat '()) "")
(check-expect (cat (cons "Leo" (cons " es" (cons " inteligente" '())))) "Leo es inteligente")
(define (cat l) 
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (cat (rest l)))]
  )
)
