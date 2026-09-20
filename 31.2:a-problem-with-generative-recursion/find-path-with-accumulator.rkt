;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname find-path-with-accumulator) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define sample-graph
  (list (list 'A 'B 'E)
        (list 'B 'E 'F)
        (list 'C 'D)
        (list 'D)
        (list 'E 'C 'F)
        (list 'F 'D 'G)
        (list 'G)))

(define cyclic-graph 
  (list (list 'A 'B 'E)
        (list 'B 'E 'F)
        (list 'C 'B 'D)
        (list 'D)
        (list 'E 'C 'F)
        (list 'F 'D 'G)
        (list 'G)
        (list 'H)))

(define ERR404 "Node not found")

;Graph Node -> [List-of Node]
;produces the list of inmediate neighbors of n in g
(define (neighbors n g)
  (cond
    [(empty? g) (error ERR404)]
    [else (if (symbol=? n (first (first g))) 
              (rest (first g)) 
              (neighbors n (rest g)))]))

;Node Node Graph -> [Maybe Path]
;finds a path from origination to destination in G
;if there is no path, the function produces #false
(define (find-path/big-boy origination destination G)
  (local (
    (define (find-path origination destination G seen)
      (cond
        [(symbol=? origination destination) (list destination)]
        [else (local ((define next (neighbors origination G))
                      (define candidate
                        (find-path/list next destination G origination seen)))
                (cond
                  [(boolean? candidate) #false]
                  [else (cons origination candidate)]))]))

    ;[List-of Node] Node Graph -> [Maybe Path]
    ;finds a path from some node on lo-Os to D
    ;if there is no path, the function produces #false
    (define (find-path/list lo-Os D G origination seen)
      (cond
        [(empty? lo-Os) #false]
        [(member? origination seen) #false]
        [else (local ((define candidate
                        (find-path (first lo-Os) D G (cons origination seen))))
                (cond
                  [(boolean? candidate)
                    (find-path/list (rest lo-Os) D G origination seen)]
                  [else candidate]))])))
    (find-path origination destination G '())))
