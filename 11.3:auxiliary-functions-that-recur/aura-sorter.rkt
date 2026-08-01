;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname aura-sorter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct p [name aura])
;a Person is a Structure:
;  (make-p String Number
;interpretation: (make-p n a) represents a person p who's 
;name is n and his aura is a

(define leo (make-p "leo" 1000))
(define sean (make-p "sean" 500))
(define manuel (make-p "manuel" 9999))

;List-Of-Persons->List-Of-Persons
;Sorts people by aura
(check-expect (aura-sorter (list manuel sean leo)) (list manuel leo sean))
(define (aura-sorter l)
  (cond
    [(empty? l) '()]
    [else (insert (first l) (aura-sorter (rest l)))]
  )
)

;Person List-Of-Persons->List-Of-Persons
;inserts a person into a sorted list
(define (insert p sl)
  (cond
    [(empty? sl) (list p)]
    [else 
      (cond
        [(aura>? p (first sl)) (cons p sl)]  
        [else (cons (first sl) (insert p (rest sl)))]
      )]
  )
)

;Person Person->Person
;return the person with more amount of aura
(check-expect (aura>? leo sean) #true)
(check-expect (aura>? manuel sean) #true)
(check-expect (aura>? leo manuel) #false)
(define (aura>? p1 p2)
  (>= (p-aura p1) (p-aura p2))
)
