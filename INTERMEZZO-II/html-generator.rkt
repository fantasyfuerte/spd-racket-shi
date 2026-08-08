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


(define my-page (web-page "Leo" "Yes, I did it"))

(show-in-browser my-page)
