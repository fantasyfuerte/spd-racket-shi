;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sort-cmp) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Number] [Number Number -> Boolean] -> [List-of Number]
;produces a version of alon, sorted according to cmp 
(define (sort-cmp alon0 cmp)
  (local(
  ;[List-of Number] -> [List-of Number]
  ;produces the sorted version of alon
  (define (isort alon)
    (cond
      [(empty? alon) '()]
      [else
        (insert (first alon) (isort (rest alon)))
      ]
    )
  )
  
  ;Number [List-of Numbers] -> [List-of Number] 
  ;inserts n into the sorted list of numbers aaaaalon
  (define (insert n alon)
    (cond
      [(empty? alon) (cons n '())]
      [else (if (cmp n (first alon))
                (cons n alon)
                (cons (first alon) (insert n (rest alon)))
            )
      ]
    )
  ))
  (isort alon0)))
