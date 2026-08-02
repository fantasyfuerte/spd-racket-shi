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

;a List-Of-Dictionaries is one of:
;--'()
;--(cons Dictionary List-Of-Dictionaries)
;interpretation: an arbitrary large list of Dictionaries

;a letter is one of the following 1Strings:
;-- "a"
;-- ...
;-- "z"
;or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz")
)

(define-struct lc [letter count])
;a LetterCount is a structure:
;  (make-lc Letter Number)
;interpretation: (make-lc l n) means
;that l was counted n times

;a List-Of-LetterCounts is one of:
;-- '()
;-- (cons LetterCount List-Of-LetterCounts)
;interpretation: an abitrary large list of LetterCounts

;Dictionary->List-Of-Dictionaries
;returns a Dictionary per Letter
(check-expect
  (words-by-first-letter 
    (list "a" "b" "c")
    (list "avellana" "almendra" "barro"))
  (list 
    (list "avellana" "almendra")
    (list "barro")
    '()))
(define (words-by-first-letter ls d)
  (cond
    [(empty? ls) '()]
    [else 
      (cons 
        (starts-with (first ls) d) 
        (words-by-first-letter (rest ls) d))]
  )
)

;Letter Dictionary->Dictionary
;counts how many words in dict start with letter
(check-expect 
  (starts-with "a" (list "analysis" "beyond")) 
  (list "analysis"))
(check-expect 
  (starts-with "a" (list "amigo" "among"))
  (list "amigo" "among"))
(check-expect 
  (starts-with "a" (list "perro" "santo"))
  '())
(define (starts-with letter dict)
  (cond
    [(empty? dict) '()]
    [else (
      cond
        [(string=? letter (first (explode (first dict))))
           (cons (first dict) (starts-with letter (rest dict)))]
        [else (starts-with letter (rest dict))]
      )]
  )
)

;Dictionary->LetterCount
;say how many times is used the most used letter of the dictionary
(check-expect 
  (most-frequent (list "arbol" "amigo" "perro")) 
  (make-lc "a" 2))
(check-expect 
  (most-frequent (list "arbol" "amigo" "below" "before" "beware")) 
  (make-lc "b" 3))
(define (most-frequent dict)
  (greater (count-by-letter LETTERS dict))
)

;Dictionary->LetterCount
;say how many times is used the most used letter of the dictionary
(check-expect (most-frequent AS-LIST)
(most-frequent.v2 AS-LIST))
(define (most-frequent.v2 dict)
  (make-lc 
    (first (explode (first (longer (words-by-first-letter LETTERS dict)))))
    (length (longer (words-by-first-letter LETTERS dict)))
  )
)

;List-Of-Dictionaries->Dictionary
;returns the longest dictionary
(define (longer l)
  (cond
    [(empty? l) '()]
    [else 
      (cond
       [(>= (length (first l)) (length(longer(rest l)))) (first l)] 
       [else (longer (rest l))]
      )]
  )
)

;List-Of-LetterCounts->LetterCount
;return the greater number on a list
(check-expect 
  (greater (list 
    (make-lc "a" 1)
    (make-lc "b" 5)
    (make-lc "c" 1)))
  (make-lc "b" 5))
(define (greater l)
  (cond 
    [(empty? (rest l)) (first l)]
    [else 
      (cond
       [(>= (lc-count (first l)) (lc-count(greater(rest l)))) (first l)] 
       [else (greater (rest l))]
      )]
  )
)

;Dictionary->List-Of-LetterCount
;count how many times is used a letter as the first of the word
(check-expect 
  (count-by-letter (list "a" "b" "c") 
  (list "amigo" "below" "car" "cool")) 
  (list 
    (make-lc "a" 1)
    (make-lc "b" 1)
    (make-lc "c" 2)
  ))
(check-expect 
  (count-by-letter (list "a" "b" "c") 
  (list "amigo" "arbol" "car" "cool"))
(list 
    (make-lc "a" 2)
    (make-lc "b" 0)
    (make-lc "c" 2)
  ))
(define (count-by-letter ls dict)
  (cond
    [(empty? ls) '()]
    [else 
      (cons 
        (make-lc (first ls)(starts-with# (first ls) dict))
        (count-by-letter (rest ls) dict)
      )
    ]
  )
)

;Letter Dictionary->Number
;counts how many words in dict start with letter
(check-expect (starts-with# "a" (list "analysis" "beyond")) 1)
(check-expect (starts-with# "a" (list "amigo" "among")) 2)
(check-expect (starts-with# "a" (list "perro" "santo")) 0)
(check-expect 
  (starts-with# "b" (list "amigo" "bro" "before" "beware" "canela" "bien")) 3)
(define (starts-with# letter dict)
  (cond
    [(empty? dict) 0]
    [(string<? letter (substring (first dict) 0 1)) 0]
    [else (
      cond
        [(string=? letter (substring (first dict) 0 1))
           (add1 (starts-with# letter (rest dict)))]
        [else (starts-with# letter (rest dict))]
      )]
  )
)
