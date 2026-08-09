;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname on-inventories-ex261) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Inventory -> Inventory
;creates an Inventory from an-inv for all those
;items that cost less than a dollar
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else 
      (cond
        [(<= (ir-price (first an-inv)) 1.0)
         (cons (first an-inv) (extract1 (rest an-inv)))]
        [else (extract1 (rest an-inv))]      
      )
    ]
  )
)
;if we use local here the performance will stay the same because
;the nested cond runs (extract1 (rest an-inv)) just once. if we use
;loca we'll only change the order of the function execution (because it
;will find the rest before the comparation)
