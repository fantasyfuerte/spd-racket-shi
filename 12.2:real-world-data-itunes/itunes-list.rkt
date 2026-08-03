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

(define llists-example (list  		        ;LList
  (list  				 	;LAssoc
    (list "Name" "Sweet Child O' Mine")  	;Association
    (list "Artist" "Guns and Roses")
    (list "Album" "Apetite for Destruction")
  )
  (list 
    (list "Name" "Dai Dai")
    (list "Artist" "Shakira")
    (list "Album" "World Cup")
  )
  (list 
    (list "Name" "Dynamite")
    (list "Artist" "BTS")
    (list "Album" "World Cup")
  )
))
