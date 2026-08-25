;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname xhtml) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/abstraction)
(require 2htdp/image)

; A Body is one of:
; - [List-of Xexpr]
; - XWord

; An Xexpr is a list:
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))

;an Attribute is a list of two items:
;  (cons Symbol (cons String '()))

;an XWord is '(word ((text String)))

(define BT (circle 10 "solid" "black"))

(define w1 '(word ((text "book"))))
(define w2 '(word ((text "hook"))))
(define w3 '(word ((text "test"))))

;Xexpr.v2 -> Symbol
;extracts the content of an xexpr
;#false otherwise
(define (xexpr-content xexpr)
  (cond
    [(empty? xexpr) #false]
    [(empty? (rest xexpr)) '()]
    [(list-of-attributes? (second xexpr)) (xexpr-content (rest xexpr))]
    [else (rest xexpr)]
  )
)

;[List-of Attribute] or Xexpr.v2 -> Boolean
;determines whether x is an element of [List-of Attribute]
;#false otherwise
(define (list-of-attributes? x)
  (cond 
    [(empty? x) #true]
    [else
      (local ((define possible-attribute (first x)))
        (cons? possible-attribute))]
  )
)

;Any -> Boolean
;determines whether any value is a word
(check-expect (word? w1) #true)
(check-expect (word? "word") #false)
(check-expect (word? '(word ((j "j")))) #false)
(define (word? x)
  (match x
    [(list 'word (list (list 'text (? string?)))) #true]
    [else #false]
  )
)

;Word -> String
;extracts the text from a word instance
(check-expect (word-text w1) "book")
(check-expect (word-text w2) "hook")
(check-expect (word-text w3) "test")
(define (word-text w) (second (first (second w))))

;an XEnum.v1 is one of:
;-- (cons 'ul [List-of XItem.v1])
;-- (cons 'ul (cons Attributes [List-of XItem.v1]))
;an XItem.v1 is one of:
;-- (cons 'li (cons XWord '()))
;-- (cons 'li (cons Attributes (cons XWord '())))

(define e0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

;XItem.v1 -> Image
;renders an item as a "word" prefixed by a bullet 
(define (render-item1 i)
  (local ((define content (xexpr-content i))
          (define element (first content))
          (define a-word (word-text element))
          (define item (text a-word 12 'black)))
    (beside/align 'center BT item)))
