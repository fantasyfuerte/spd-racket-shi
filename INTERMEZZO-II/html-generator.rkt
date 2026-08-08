;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname html-generator) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/web-io)

;String String -> ... deeply nested list ...
;produces a web page with given author and title
(define (web-page author title)
  `(html
     (head
       (title ,title)
       (meta ((http-equiv "content-type")
              (content "text-html"))))
     (body
       (h1 ,title)
       (p "I, " ,author ", made this page.")
       (table ((border "1"))
         (tr ,@(make-row '(1 2 3 4)))
         (tr ,@(make-row '(5 10 15 20)))
       )
      ,(make-ranking `,one-list)
     )
   )
) 

;List-Of-Numbers-> ...nested list...
;creates a row for an HTML table from 1
(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l))
                (make-row (rest l)))]
  )
)

;Number-> ...nested list...
;creates a cell for an HTML table from a number
(define (make-cell n)
  `(td ,(number->string n)))

(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

(define (ranking los)
  (reverse (add-ranks (reverse los)))
)

(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los)) (add-ranks (rest los)))]
  )
)

;List-Of-Strings->...nested list...
;produces a list representation of an HTML table
(define (make-ranking l)
`(table ((border "1")) 
   ,@(make-ranking-row (ranking l))
 )
)
(define (make-ranking-row l)
  (cond
    [(empty? l) '()]
    [else
      (cons
        `(tr (td ,(number->string (first (first l))))
             (td ,(second (first l))))
        (make-ranking-row (rest l)))]))

(define my-page (web-page "Leo" "Yes, I did it"))
(show-in-browser my-page)
