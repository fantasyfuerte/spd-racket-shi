;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname pick-from-tree) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct branch [left right])

;a TOS is one of:
;-- Symbol
;-- (make-branch TOS TOS)

;a Direction is one of:
;-- 'left
;-- 'right

;TOS [List-of Direction] -> TOS
;produces the TOS in the specified direction
(check-expect (tree-pick 'a '()) 'a)
(check-expect (tree-pick (make-branch 'a 'b) '(right)) 'b)
(check-expect (tree-pick (make-branch 'a 'b) '(right)) 'b)
(check-expect 
  (tree-pick (make-branch 'a (make-branch 'a 'a)) '(right)) 
  (make-branch 'a 'a))
(check-expect 
  (tree-pick (make-branch 'a (make-branch 'a 'z)) '(right left)) 
  'a)
(check-error 
  (tree-pick (make-branch 'a (make-branch 'a 'z)) '(right left left)) 
  "tree has ended")
(define (tree-pick tos lds)
  (cond
    [(empty? lds) tos]
    [(symbol? tos) (error "tree has ended")]
    [else
      (cond
        [(symbol=? 'right (first lds)) 
          (tree-pick (branch-right tos) (rest lds))]
        [else 
          (tree-pick (branch-left tos) (rest lds))]
      )]))
