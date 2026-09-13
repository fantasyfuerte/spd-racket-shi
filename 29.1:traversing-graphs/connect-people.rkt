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
(check-error (neighbors sample-graph 'Z) ERR404)
(define (neighbors g n)
  (cond
    [(empty? g) (error ERR404)]
    [else (if (symbol=? n (first (first g))) 
              (rest (first g)) 
              (neighbors (rest g) n))]))

;a Path is a [List-of Node]
;interpretation: the list of nodes specifies a sequence of
;inmediate neighbors that leads from the first Node on the 
;list to the last one

;Node Node Graph -> [Maybe Path]
;finds a path from origination to destination in G
(check-expect (find-path 'C 'D sample-graph)
              '(C D))
(check-member-of (find-path 'E 'D sample-graph)
                 '(E F D) '(E C D))
(check-expect (find-path 'C 'G sample-graph) #false)
(define (find-path origination destination G)
  (cond 
    [(symbol=? origination destination) (list destination)]
    [else (local(
                 (define next (neighbors G origination))
                 (define candidate 
                   (find-path/list next destination G)))
                 (cond
                   [(boolean? candidate) #false]
                   [else (cons origination candidate)]
                   ))]))

;[List-of Node] Node Graph -> [Maybe Path]
;finds a path from some node on lo-originations to destination
;otherwise it produces #false
(define (find-path/list lo-Os D G)
  (cond
    [(empty? lo-Os) #false]
    [else (local ((define candidate
                    (find-path (first lo-Os) D G)))
            (cond
              [(boolean? candidate)
               (find-path/list (rest lo-Os) D G)]
              [else candidate]))]))
