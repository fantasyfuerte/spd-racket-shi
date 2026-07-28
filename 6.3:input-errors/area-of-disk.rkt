;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname area-of-disk) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Number->Number
(define (area-of-disk r) 
  (* pi (sqr r))
)

;Any->...
(define (checked-area-of-disk r)
  (cond
    [(and(number? r)(>= r 0))(area-of-disk r)]
    [else (error "POSITIVE NUMBER EXPECTED")]
  )
)

;Any->...
;Check if a given input is a MissileOrNot
(check-expect (missile-or-not? (make-posn 0 0)) #true)
(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? #true) #false)
(define (missile-or-not? v) 
  (cond
    [(or(false? v)(posn? v)) #true]
    [else #false]
  )
)
