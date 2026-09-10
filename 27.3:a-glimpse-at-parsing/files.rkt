;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define NEWLINE "\n")

;a File is one of:
;-- '()
;-- (cons "\n" File)
;-- (cons 1String File)
;interpretation: represents the content of a file
;"\n" is the newline character

;a Line is a [List-of 1String]

;File -> [List-of Line]
;converts a file into a list of lines
(check-expect (file->list-of-lines
                (list "a" "b" "c" "\n"
                      "d" "e" "\n"
                      "f" "g" "h" "\n"))
              (list (list "a" "b" "c")
                    (list "d" "e")
                    (list "f" "g" "h")))
(define (file->list-of-lines afile) 
  (cond
    [(empty? afile) '()]
    [else
      (cons (first-line afile)
            (file->list-of-lines (remove-first-line afile)))]))

;File->Line
;returns the first line of a file
(define (first-line afile)
  (cond
    [(empty? afile) '()]
    [(string=? (first afile) NEWLINE) '()]
    [else (cons (first afile) (first-line (rest afile)))]))

;File -> [List-of Lines]
;removes the first line of a file
(define (remove-first-line afile)
  (cond
    [(empty? afile) '()]
    [(string=? (first afile) NEWLINE) (rest afile)]
    [else (remove-first-line (rest afile))]))

;a Word is a String without whitespaces

;Line -> [List-of Words]
;appends the letters and drops the spaces
(check-expect
  (tokenize 
    (list "h" "i" " " "h" "o" "w" " " "a" "r" "e" " " "y" "o" "u"))
  (list "hi" "how" "are" "you"))
(check-expect
  (tokenize 
    (list "h" "i" " " " " "h" "o" "w" " " "a" "r" "e" " " "y" "o" "u"))
  (list "hi" "how" "are" "you"))
(define (tokenize line)
  (local (
          (define (get-first-word l)
            (cond
              [(or (empty? l) (string-whitespace? (first l))) '()]
              [else (cons (first l) (get-first-word (rest l)))]))
          (define (drop-first-word l)
            (cond
              [(empty? l) '()]
              [(string-whitespace? (first l)) (rest l)]
              [else (drop-first-word (rest l))]))
          (define first-word (implode (get-first-word line))))
          (cond
            [(empty? line) '()]
            [else (if (string-whitespace? first-word) 
                      (tokenize (drop-first-word line))
                      (cons first-word 
                            (tokenize (drop-first-word line))))])))
