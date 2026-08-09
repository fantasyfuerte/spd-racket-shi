;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname listing-foldr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct address [first-name last-name street])
;an Addr is a sructure:
;  (make-address String String String)
;interpretation: associates an address with a person's name

;[List-of Addr]->String
;creates a string from first names, sorted in alphabetical order,
;separated and surrounded by blank spaces
(define (listing l)
  (foldr string-append-with-space " " 
    (sort (map address-first-name l) string<?)))

;String String -> String
;appends two strings, prefixes with " "
(define (string-append-with-space s t)
  (string-append " " s t))

(define ex0
  (list (make-address "Robert" "Findler" "South")
        (make-address "Matthew" "Flatt" "Canyon")
        (make-address "Shriram" "Krishna" "Yellow")))

(check-expect (listing ex0) " Matthew Robert Shriram ")
