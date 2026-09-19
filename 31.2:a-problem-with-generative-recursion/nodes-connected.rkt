;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname nodes-connected) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a SimpleGraph is a [List-of Connection]
;a Connection is a list of two items:
;  (list Node Node)
;a Node is a Symbol

(define a-sg '(
               (A B)
               (B C)
               (C E)
               (D E)
               (E B)
               (F F)
               ))

;Node Node SimpleGraph -> Boolean 
;is there a path from origin to destination in the simple graph sg
(check-expect (path-exist? 'A 'E a-sg) #true)
(check-expect (path-exist? 'A 'F a-sg) #false)
(define (path-exist? origin destination sg)
  (cond
    [(symbol=? origin destination) #t]
    [else (path-exist? (neighbor origin sg)
                       destination
                       sg)]))

;Node SimpleGraph -> Node
;determine the node that is connected to a-node in sg
(check-expect (neighbor a-node sg)
              (cond
                [(empty? sg) (error "neighbor: not a node")]
                [else (if (symbol=? (first (first sg)) a-node)
                          (second (first sg))
                          (neighbor a-node (rest sg)))]))
