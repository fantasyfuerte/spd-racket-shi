;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname listing-with-foldr.v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct address [first-name last-name street])
;an Addr is a sructure:
;  (make-address String String String)
;interpretation: associates an address with a person's name

;[List-of Addr] -> String
;creates a string of first names, sorted in alphabetical order,
;separated and surrounded by blank spaces
(define (listing.v2 l)
  (local(
    (define names (map address-first-name l))
    (define sorted (sort names string<?))
    ;String String -> String
    ;appends two strings,prefix with " "
    (define (helper s t)
      (string-append " " s t))
    (define concat+spaces
      (foldr helper " " sorted)))
  concat+spaces))

;String String -> String
;appends two strings, prefixes with " "
(define (string-append-with-space s t)
  (string-append " " s t))

(define ex0
  (list (make-address "Robert" "Findler" "South")
        (make-address "Matthew" "Flatt" "Canyon")
        (make-address "Shriram" "Krishna" "Yellow")))

(check-expect (listing.v2 ex0) " Matthew Robert Shriram ")
