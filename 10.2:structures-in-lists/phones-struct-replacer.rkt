;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname phones-struct-replacer) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct phone [area switch four])
; a Phone is a structure: 
;   (make-phone Three Three Four) 
; a Three is a Number between 100 and 999. 
; a Four is a Number between 1000 and 9999

;a List-Of-Phones is one of:
;-- '()
;-- (cons Phone List-Of-Phones)
;interpretation: an arbitrary large list of phones

;List-Of-Phones->List-Of-Phones
;produces the same list with all area-code occurrences of 713 replaced by 281
(check-expect (replace empty) empty)
(check-expect (replace (cons (make-phone 713 444 444) (cons (make-phone 333 333 333) empty))) (cons (make-phone 281 444 444) (cons (make-phone 333 333 333) empty)))
(define (replace l)
  (cond
    [(empty? l) '()]
    [else 
      (cond
        [(= (phone-area (first l)) 713) (cons (make-phone 281 (phone-switch (first l)) (phone-four (first l))) (replace (rest l)))]
        [else (cons (make-phone (phone-area (first l)) (phone-switch (first l)) (phone-four (first l))) (replace (rest l)))]
      )
    ]
  )
)
