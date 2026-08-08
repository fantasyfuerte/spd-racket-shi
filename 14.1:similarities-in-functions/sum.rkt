;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Lon->Lon
;adds 1 to each item on l
(check-expect (add1* '(1 2 3)) '(2 3 4))
(define (add1* l)
  (cond
    [(empty? l) '()]
    [else 
      (cons
      (add1 (first l))
      (add1* (rest l)))
    ]
  )
)

;Lon->Lon
;adds 5 to each item on l
(check-expect (plus5 '(1 2 3)) '(6 7 8))
(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else
      (cons
        (+ (first l) 5)
        (plus5 (rest l)))
    ]
  )
)

;Lon Number->Lon
;adds n to each iten on l
(check-expect (sum 5 '(1 2 3)) '(6 7 8))
(check-expect (sum 1 '(1 2 3)) '(2 3 4))
(define (sum n l)
  (cond
    [(empty? l) '()]
    [else (cons (+ n (first l)) (sum n (rest l)))]
  )
)

(define (plus5.v2 l)
  (sum 5 l)
)

(define (add1*.v2 l)
  (sum 1 l)
)
