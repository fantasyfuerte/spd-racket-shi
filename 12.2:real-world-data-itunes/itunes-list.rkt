;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname itunes-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/itunes)

(define ITUNES-LOCATION "itunes.xml") 

;LLists
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))

;an LList is one of:
;-- '()
;-- (cons LAssoc LLists)

;an LAssoc is one of:
;-- '()
;-- (cons Association LAssoc)

;an Association is a list of two items:
;  (cons String (cons BSDN '()))

;a BSDN is one of:
;-- Boolean
;-- String
;-- Date
;-- Number

(define la1 (list
    (list "Name" "Sweet Child O' Mine")
    (list "Artist" "Guns and Roses")
    (list "Album" "Apetite for Destruction")
    (list "Total Time" 213096)
    (list "Play Count" 19)
  ))

(define la2 (list 
    (list "Name" "Dai Dai")
    (list "Artist" "Shakira")
    (list "Album" "World Cup")
    (list "Total Time" 218096)
    (list "Play Count" 9)
  ))

(define la3 (list 
    (list "Name" "Dynamite")
    (list "Artist" "BTS")
    (list "Album" "World Cup")
    (list "Total Time" 203096)
    (list "Play Count" 4)
  ))

(define llists-example (list
  la1
  la2
  la3
))

;a Key is a String

;LList->Number
;produces the total amount of playtime
(check-expect 
  (total-time/list llists-example) 
  (+ (* 4 203096) (* 9 218096) (* 19 213096))) 
(define (total-time/list l)
  (cond
    [(empty? l) 0]
    [else 
    (+ 
      (* (second (find-association "Total Time" (first l) (list "Total Time" 0)))
      (second (find-association "Play Count" (first l) (list "Play Count" 0))))
      (total-time/list (rest l))
    )
    ]
  )
)

;Key LAssoc Any->Association
;returns the first Association whose first item is equal to key
(check-expect 
  (find-association "Name" la2 (list "Name" "NotFound"))
  (list "Name" "Dai Dai")) 
(check-expect 
  (find-association "Namee" la3 (list "Name" "NotFound"))
  (list "Name" "NotFound")) 
(define (find-association k LA default)
  (cond
    [(empty? LA) default]
    [else
      (cond
        [(string=? (first (first LA)) k) (first LA)]
        [else (find-association k (rest LA) default)]
      )]
  )
)
