;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname prefixes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-1Strings is one of
;-- '()
;-- (cons 1String List-Of-1Strings)
;interpretation: an arbitrary large list of 1Strings

;a List-Of-Lists-Of-1Strings is one of:
;-- '()
;-- (cons List-Of-Strings List-Of-Lists-Of-1String)
;interpretation: an arbitrary large list of lists

;List-Of-1Strings->List-Of-Lists-Of-1Strings
;returns a list with the suffixes of l
(check-expect
  (suffixes (list "1" "2" "3"))
(list (list "1" "2" "3") (list "2" "3") (list "3")))
(define (suffixes l)
  (cond 
    [(empty? l) '()]
    [else (cons l (suffixes (rest l)))]
  )
)


;List-Of-1Strings->List-Of-Lists-Of-1Strings
;returns a list with the prefixes of l
(check-expect 
  (prefixes (list "1" "2" "3"))
  (list (list "1" "2" "3") (list "1" "2") (list "1")))
(define (prefixes l)
  (cond
    [(empty? l) '()]
    [else (cons l (prefixes (del-last l)))]
  )
)

;List-Of-1Strings->List-Of-1Strings
;returns the lists without the last element
(check-expect (del-last (list "2" "3")) (list "2"))
(define (del-last l)
  (cond 
    [(empty? (rest l)) empty ]
    [else (cons (first l) (del-last (rest l)))]
  )
)

