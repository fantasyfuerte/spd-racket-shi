;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname encoding) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

;a List-Of-Strings is one of:
;--'()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings


;a List-Of-List-Of-Strings (LLS) is one of:
;-- '()
;-- (cons List-Of-Strings List-Of-List-Of-Strings)
;interpretation: an arbitrary large LLS

;String->Void
;creates a "encoded-"+n file with the content of n
(define (encode-file n)
  (write-file 
    (string-append "encoded-" n)
    (collapse (encode-lls (read-words/line n)))
  )
)

;LLS->LLS
;encode a LLS
(define (encode-lls l)
  (cond 
    [(empty? l) '()]
    [else (cons (encode-ls(first l))  (encode-lls (rest l)))]
  )
)

;List-Of-Strings->List-Of-Strings
;encode a list of strings
(define (encode-ls l)
  (cond
    [(empty? l) '()]
    [else (cons (encode-w(explode(first l))) (encode-ls(rest l)))]
  )
)

;List-Of-Strings->String
;encodes a word
(define (encode-w l)
  (cond 
    [(empty? l) ""] 
    [else (string-append (encode-letter (first l))(encode-w (rest l)))]
  )
)

;1String->String
;converts the given 1String to a 3-letter numeric String
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
      (string-append "00" (code1 s))]
    [(< (string->int s) 100)
      (string-append "0" (code1 s))]
  )
)

;1String->1String
;converts the given 1String into a String
(check-expect (code1 "z") "122")
(define (code1 c)
  (number->string (string->int c))
)

;LLS->String
;produces a string with all the content of the file
(define (collapse l)
  (cond
    [(empty? l) ""]
    [else (string-append (append-line(first l)) (if (empty? (rest l)) "" "\n") (collapse (rest l)))]
  )
)

;List-Of-Strings->String
;produces a string from a list of strings
(define (append-line l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (if (empty? (rest l)) "" " ") (append-line (rest l)))]
  )
)

(encode-file "ttt.txt")
