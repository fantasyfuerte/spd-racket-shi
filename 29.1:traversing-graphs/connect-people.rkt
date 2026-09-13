;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname connect-people) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define sample-graph
  (list (list 'A 'B 'E)
        (list 'B 'E 'F)
        (list 'C 'D)
        (list 'D)
        (list 'E 'C 'F)
        (list 'F 'D 'G)
        (list 'G)))

; a Node is a Symbol

;a Graph is a [List-of NodeAssoc]

;a NodeAssoc is a [List-of Node]

(define ERR404 "Node not found")

;Graph Node -> [List-of Node]
;produces the list of inmediate neighbors of n in g
(check-expect (neighbors sample-graph 'A) '(B E))
(check-expect (neighbors sample-graph 'B) '(E F))
(define (neighbors g n)
  (cond
    [(empty? g) (error ERR404 n)]
    [else (if (symbol=? n (first(first g))) 
              (rest (first g)) 
              (neighbors (rest g) n))]))
