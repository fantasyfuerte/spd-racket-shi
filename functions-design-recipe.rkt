;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functions-design-recipe) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;String -> 1String
;Gives the first character of a text
;given: "Hello" expects: "H"
;given: "1234" expects: "1"
(define (string-first s)
  (substring s 0 1))

(check-expect (string-first "Hello") "H")
(check-expect (string-first "1234") "1")

;String -> 1String
;Gives the last string of a text
;given: "Hello" expects "o"
;given: "1234" expects "4"
(define (string-last s)
  (substring s (sub1(string-length s)) (string-length s)))

(check-expect (string-last "Hello") "o")
(check-expect (string-last "1234") "4")

;Image -> Number
;Gives the area in pixels of an image
;given (rectangle 20 20 "solid" "red") expects 400
;given (rectangle 30 30 "solid" "blue") expects 900
(define (image-area i)
  (*(image-width i) (image-height i)))

(check-expect (image-area (rectangle 20 20 "solid" "red")) 400)
(check-expect (image-area (rectangle 30 30 "solid" "blue")) 900)


;String -> String
;Gives the same string without his first character
;given: "Helllo" expects: "elllo"
;given: "123" expects: "23"
(define (string-rest s)
  (substring s 1 (string-length s)))

(check-expect (string-rest "Helllo") "elllo")
(check-expect (string-rest "123") "23")

;String -> String
;Gives the same string without his last character
;given: "Helllo" expects: "Helll"
;given: "123" expects: "12"
(define (string-remove-last s)
  (substring s 0 (sub1 (string-length s))))

(check-expect (string-remove-last "Helllo") "Helll")
(check-expect (string-remove-last "123") "12")
