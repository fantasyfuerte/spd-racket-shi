;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname design-recipes-for-abtractions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;1- Compare items for similarities

;List-of-numbers->List-of-numbers
;converts a list of celsius to fahrenheit
(define (cf* l)
  (cond
    [(empty? l) '()]
    [else 
      (cons
        (C2F (first l))
        (cf* (rest l)))
    ]
  )
)

;Inventory->List-of-strings
;extracts the names of toys from an inventory
(define (names i)
  (cond
    [(empty? i) '()]
    [else
      (cons 
        (IR-name (first i))
        (names (rest i)))
    ]
  )
)

;Number->Number
;converts celsius to fahrenheit
(define (C2F c)
  (+ (* 9/5 c) 32))

(define-struct IR [name price])
;an IR is a structure:
;  (make-IR String Number)
;an Inventory is one of:
;-- '()
;-- (cons IR Inventory)

;Here the only thing in what functions differ is in which function
;they apply to each item on the list

;2- Abstract
;in this case we replace the function they're calling for a name, and
;we put that name into a parameter

;List-of-numbers->List-of-numbers
;converts a list of celsius to fahrenheit
(define (cf*.v2 l f)
  (cond
    [(empty? l) '()]
    [else 
      (cons
        (f (first l))
        (cf*.v2 (rest l) f))
    ]
  )
)

;Inventory->List-of-strings
;extracts the names of toys from an inventory
(define (names.v2 i f)
  (cond
    [(empty? i) '()]
    [else
      (cons 
        (f (first i))
        (names.v2 (rest i) f))
    ]
  )
)

;now the functions are the same

(define (map* l f)
  (cond
    [(empty? l) '()]
    [else 
      (cons
        (f (first l))
        (map* (rest l) f))
    ]
  )
)

;3-Validate the new function
;here we define the original functions in terms of the abstraction
;and the we start to test

;List-of-numbers->List-of-numbers
(check-expect (cf*.abstracted '(20 20 40)) (cf* '(20 20 40)))
(define (cf*.abstracted l)
  (map* l C2F)
)

;Inventory->List-of-strings
(check-expect 
  (names.abstracted `( ,(make-IR "test" 20) ,(make-IR "test" 20))) 
  (names `( ,(make-IR "test" 20) ,(make-IR "test" 20))))
(define (names.abstracted l)
  (map* l IR-name)
)
