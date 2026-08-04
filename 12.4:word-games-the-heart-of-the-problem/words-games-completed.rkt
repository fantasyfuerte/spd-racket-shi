;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname words-games-completed) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)
(define LOCATION "/usr/share/dict/words")
;a Dictionary is a List-Of-Strings
(define DICTIONARY (read-lines LOCATION))

;a List-Of-Strings is one of:
;--'()
;--(cons String List-Of-String)
;interpretation: an arbitrary large list of strings

;a Word is one of:
;-- '()
;-- (cons 1String Word)
;interpretation: a Word is a list of 1Strings (letters)

;a List-Of-Words is one of:
;--'()
;--(cons Word List-Of-Words)
;interpretation: an arbitrary large list of words

;Word->List-Of-Words
;finds all rearrangements of word
(check-satisfied (arrangements (list "c" "a" "t"))
all-cat-arrangements?)
(define (arrangements w)
  (cond
    [(empty? w) '()]
    [(empty? (rest w)) (list( list (first w)))]
    [else (insert-everywhere/in-all-words (first w)(arrangements (rest w)))]
  )
)

;1String List-Of-Words->List-Of-Words
;inserts the 1String at the beginning, middle and end of every word
(check-expect 
  (insert-everywhere/in-all-words "c" 
    (list  
      (list "a" "t")
      (list "t" "a")
    )) 
  (list (list "c" "a" "t") (list "a" "c" "t") (list "a" "t" "c") (list "c" "t" "a") (list "t" "c" "a") (list "t" "a" "c")))
(define (insert-everywhere/in-all-words s l)
  (cond
    [(empty? l) '()]
    [else (append 
            (insert-everywhere s (first l))
            (insert-everywhere/in-all-words s (rest l)))]
  )
)

(define (create-set l)
  (cond
    [(empty? l) '()]
    [else
      (cond 
        [(member? (first l) (create-set (rest l))) (create-set (rest l))]
        [else (cons (first l) (create-set (rest l)))]
      )
    ]
  )
)

;1String Word->List-Of-Words
;inserts the character everywhere in the string
(define (insert-everywhere s l)
  (cond
    [(empty? l) (list (list s))]
    [else 
    (create-set
      (append
        (list 
          (insert-beginning s l) 
          (insert-end s l) 
          (append (list(first l)) (insert-beginning s (rest l)))
         
        )
        (prepend (first l) (insert-everywhere s (rest l))))
   )]
  )
)

;1String List-Of-Words->List-Of-Words
;puts a prefix s in every word
(check-expect (prepend "c" (list (list "a" "t") (list "a" "r")))
  (list (list "c" "a" "t")
  (list "c" "a" "r")
))
(define (prepend s l)
  (cond
    [(empty? l) '()]
    [else (cons (insert-beginning s (first l)) (prepend s (rest l)))]
  )
)

;1String Word ->Word
;inserts s at the beginning of the word
(check-expect (insert-beginning "c" (list "a" "t")) (list "c" "a" "t"))
(define (insert-beginning s w)
  (append (list s) w)
)

;1String Word ->Word
;inserts s at the end of the word
(define (insert-end s w)
  (append w (list s))
)

;List-Of-Words->Boolean
;verifies the cat arrangements
(define (all-cat-arrangements?  l)
  (and (member? (list "c" "a" "t") l) 
       (member? (list "a" "c" "t") l)
       (member? (list "t" "a" "c") l))
)

;List-Of-Strings->List-Of-Strings
;given a list of string search whose occur in the dictionary
(check-expect (in-dictionary (list "cat" "tac" "act")) (list "cat" "act"))
(define (in-dictionary l)
  (cond
    [(empty? l) '()]
    [else 
      (cond
        [(member? (first l) DICTIONARY) (cons (first l) (in-dictionary (rest l)))]
        [else (in-dictionary (rest l))]
      )
    ]
  )
)

;String->List-Of-Strings
;finds all words that use the same letters as s
(check-member-of 
  (alternative-words "cat")
  (list "act" "cat")
  (list "cat" "act"))
(check-satisfied (alternative-words "rat")
  all-words-from-rat?)
(define (alternative-words s)
  (in-dictionary 
    (words->strings
      (arrangements (string->word s)))))

;List-Of-Words->List-Of-Strings
;turns all words into a list of strings
(check-expect
  (words->strings
    (list (list "t" "h" "i" "s") 
          (list "i" "s") 
          (list "a" "n") 
          (list "e" "x" "a" "m" "p" "l" "e")))
    (list "this" "is" "an" "example")) 
(define (words->strings l)
  (cond
    [(empty? l) '()]
    [else (cons (word->string (first l)) (words->strings (rest l)))]
  )
)

;List-Of-Strings->Boolean
(define (all-words-from-rat? w)
  (and (member? "rat" w)
       (member? "art" w)
       (member? "tar" w) 
  )
)

;String->Word
;converts s to the chosen word representation
(check-expect(string->word "leo") (list "l" "e" "o"))
(check-expect(string->word "hello") (list "h" "e" "l" "l" "o"))
(define (string->word s)
 (explode s)
)

;Word->String
;converts w to a string
(check-expect (word->string (list "l" "e" "o")) "leo")
(define (word->string w)
  (implode w)
)
