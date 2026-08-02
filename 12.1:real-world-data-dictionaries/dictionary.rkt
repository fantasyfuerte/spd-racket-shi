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
