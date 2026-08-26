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

(define BT (circle 2 "solid" "black"))

(define w1 '(word ((text "book"))))
(define w2 '(word ((text "hook"))))
(define w3 '(word ((text "test"))))

;Xexpr.v2 -> Symbol
;extracts the content of an xexpr
;#false otherwise
(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (if (list-of-attributes? (first optional-loa+content))
           (rest optional-loa+content)
           optional-loa+content)])))

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
(define (word-text w)
  (match w
    [(list 'word (list (list 'text txt))) txt]))

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
          (define item (text a-word 15 'black)))
    (beside/align 'center BT item)))

;XEnum.v1 -> Image
;renders a simple enumeration as an image
(define (render-enum1 xe)
  (local ((define content (xexpr-content xe))
          ;XItem.v1 Image -> Image
          (define (deal-with-one item so-far)
            (above/align 'left (render-item1 item) so-far)))
    (foldr deal-with-one empty-image content)))

;An XItem.v2 is one of:
;-- (cons 'li (cons XWord '()))
;-- (cons 'li (cons [List-of Attribute] (list XWord)))
;-- (cons 'li (cons XEnum.v2 '()))
;-- (cons 'li (cons [List-of Attribute] (list XEnum.v2)))

;An XEnum.v2 is one of:
;-- (cons 'ul [List-of XItem.v2])
;-- (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))

(define SIZE 15)

;Image -> Image
;marks item with bullet
(define (bulletize item)
  (beside/align 'center BT item))

;XEnum.v2 -> Image
;renders an XEnum.v2 as an image
(define (render-enum xe)
  (local ((define content (xexpr-content xe))
          ;XItem.v1 Image -> Image
          (define (deal-with-one item so-far)
            (above/align 'left (render-item item) so-far)))
    (foldr deal-with-one empty-image content)))

;XItem.v2 -> Image
;renders one XItem.v2 as an image
(define (render-item an-item)
  (local ((define content (first (xexpr-content an-item))))
    (bulletize
      (cond
        [(word? content)
         (text (word-text content) SIZE 'black)]
      [else (render-enum content)]))))

(define input1 
  '(ul (li (word ((text "hello")))) 
       (li (word ((text "hello"))))))
(define input2 
  '(ul (li (word ((text "hello12")))) 
       (li (word ((text "hello"))))))

;XEnum.v2 -> Number
;counts all "hello"'s in an instance of e
(check-expect (count-hello input1) 2)
(check-expect (count-hello input2) 1)
(define (count-hello e)
  (cond
    [(empty?(xexpr-content e)) 0] 
    [else (local(
      (define (count element so-far)
        (if (word? (first (xexpr-content element)))
            (if 
              (string=? "hello" 
                        (word-text (first (xexpr-content element))))
              (add1 so-far) so-far)
            (count-hello element)))
    )(foldr count 0 (xexpr-content e)))]   
  )
)
