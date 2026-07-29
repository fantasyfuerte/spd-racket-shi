;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname list-of-temperatures-average) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Temperatures is one of:
;-- '()
;-- (cons CTemperature List-Of-Temperatures)
;interpretation: an arbitrary large list of temperatures

;a NELList-Of-Temperatures is one of:
;-- (cons CTemperature '())
;-- (cons CTemperature List-Of-Temperatures)
;interpretation: an arbitrary large non-empty-list of temperatures

;a CTemperature is a Number greater than -272

;NEList-Of-Temperatures->Number
;computes the average temperature
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)
(define (average l) 
  (cond
    [(empty? l) (error "average: list cannot be an empty list")]
    [else 
      (/ (sum l) (how-many l))
    ]
  )
)

;List-Of-Temperatures->Number
;computes the sum of every temperature on the list
(check-expect (sum '()) 0)
(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect (sum (cons 9 (cons 2 (cons 3 '())))) 14)
(define (sum l)
  (cond
    [(empty? l) 0]
    [else (+(first l)(sum (rest l)))]
  )
)

;List-Of-Temperatures->Number
;computes how many temperatures the list have
(check-expect (how-many '()) 0)
(check-expect (how-many (cons 1 (cons 2 '()))) 2)
(check-expect (how-many (cons 1 (cons 2 '()))) 2)
(define (how-many l)
  (cond
    [(empty? l) 0]
    [else (add1 (how-many (rest l)))]
  )
)

;NEList-Of-Temperatures->Number
;Computes the sum of every temperature on the non-empty-list
(check-expect (nel-sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect (nel-sum (cons 9 (cons 2 (cons 3 '())))) 14)
(define (nel-sum l) 
  (cond
    [(empty? (rest l))(first l)]
    [else (+(first l) (nel-sum (rest l)))]
  )
)

;NEList-Of-Temperatures->Number
;computes how many temperatures the non-empty-list have
(check-expect (nel-how-many (cons 1 (cons 2 '()))) 2)
(check-expect (nel-how-many (cons 1 (cons 2 '()))) 2)
(define (nel-how-many l) 
  (cond
    [(empty? (rest l))1]
    [else (add1 (nel-how-many (rest l)))]
  )
)


