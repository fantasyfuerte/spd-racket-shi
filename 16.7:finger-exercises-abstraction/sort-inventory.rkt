;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sort-inventory) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct inv-i [name desc acq-price sales-price])
;an InventoryItem is a structure:
;  (make-inv-i String String Number Number)
;interpretation: (make-inv-i a b c d) represenrs an item with a name
;b description c acquisition price d sales price

;[List-of InventoryItem] -> [List-of InventoryItem]
;sorts l by the difference between sales and acquisition price
(define (sort-by-profit l)
  (local( 
    ;InventoryItem InventoryItem -> Boolean
    (define (more-profitable? i1 i2)
      (> (- (inv-i-sales-price i1) (inv-i-acq-price i1))
         (- (inv-i-sales-price i2) (inv-i-acq-price i2)))
    )
  )
  (sort l more-profitable?))
)

;Number [List-of InventoryItem] -> [List-of InventoryItem]
;produces a list of all those items whose sales price is below ua
(define (eliminate-expensive ua l)
  (local(
    ;InventoryItem -> Boolean
    ;yields true if the sales price is below ua
    (define (below-ua? i) (> (inv-i-sales-price i) ua))    
  )
  (filter below-ua? l))
)

;String [List-of InventoryItem] -> [List-of InventoryItem]
;produces a list of all those items whose names isn't ty
(define (recall ty l)
  (local(
    ;InventoryItem -> Boolean
    ;yields true if the isn't ty
    (define (not-ty? i) (not (string=? (inv-i-ty i) ty)))    
  )
  (filter not-ty? l))
)
