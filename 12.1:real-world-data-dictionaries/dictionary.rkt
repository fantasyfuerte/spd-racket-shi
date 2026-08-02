;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname dictionary) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

(define LOCATION "/usr/share/dict/words")

;a List-Of-Strings is one of:
;-- '()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings

;a Dictionary is a List-Of-Strings
(define AS-LIST (read-lines LOCATION))

;a letter is one of the following 1Strings:
;-- "a"
;-- ...
;-- "z"
;or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz")
)

;Dictionary->Number
;say how many times is used the most used letter of the dictionary
(check-expect (most-frequent (list "arbol" "amigo" "perro")) 2)
(check-expect (most-frequent (list "arbol" "amigo" "below" "before" "beware")) 3)
(define (most-frequent dict)
  (greater (count-by-letter LETTERS dict))
)

;List-Of-Numbers->Number
;return the greater number on a list
(check-expect (greater (list 1 2 3)) 3)
(check-expect (greater (list 10 2 3)) 10)
(check-expect (greater (list 50 2 3)) 50)
(define (greater l)
  (cond 
    [(empty? l) 0]
    [else (max (first l) (greater (rest l)))]
  )
)

;Dictionary->List-Of-Numbers
;count how many times is used a letter as the first of the word
(check-expect 
  (count-by-letter (list "a" "b" "c") 
  (list "amigo" "below" "car" "cool")) (list 1 1 2))
(check-expect 
  (count-by-letter (list "a" "b" "c") 
  (list "amigo" "arbol" "car" "cool")) (list 2 0 2))
(define (count-by-letter ls dict)
  (cond
    [(empty? ls) '()]
    [else 
      (cons (starts-with# (first ls) dict) (count-by-letter (rest ls) dict))]
  )
)

;Letter Dictionary->Number
;counts how many words in dict start with letter
(check-expect (starts-with# "a" (list "analysis" "beyond")) 1)
(check-expect (starts-with# "a" (list "amigo" "among")) 2)
(check-expect (starts-with# "a" (list "perro" "santo")) 0)
(define (starts-with# letter dict)
  (cond
    [(empty? dict) 0]
    [else (
      cond
        [(string=? letter (first (explode (first dict))))
           (add1 (starts-with# letter (rest dict)))]
        [else (starts-with# letter (rest dict))]
      )]
  )
)
