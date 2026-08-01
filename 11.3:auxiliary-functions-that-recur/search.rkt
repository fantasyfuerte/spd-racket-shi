;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname search) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Numbers is one of:
;-- '()
;-- (cons Number List-Of-Numbers)
;interpretation: an arbitrary large size list of numbers

;Number List-Of-Number -> Boolean
;search n in alon
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n) (search n (rest alon)))]
  )
)

;Number List-Of-Numbers (sorted>)-> Boolean
;search n in alon
(check-expect (sorted-search 10 (list 11 10 9)) #true)
(check-expect (sorted-search 10 (list 11 10.5 9)) #false)
(check-expect (sorted-search 10 (list 11 10.5 9)) #false)
(check-expect (sorted-search 10 (list 131 20 4 10)) #false)
(check-expect (sorted-search 1 empty) #false)
(define (sorted-search n l)
  (cond
    [(empty? l) #false]
    [else (cond
        [(> n (first l)) #false]
        [else (or (= (first l) n) (sorted-search n (rest l)))]
      )
    ]
  )
)
