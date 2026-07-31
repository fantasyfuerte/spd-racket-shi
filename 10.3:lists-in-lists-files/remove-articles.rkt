;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname remove-articles) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

;a List-Of-Strings is one of:
;--'()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings


;a List-Of-List-Of-Strings (LLS) is one of:
;-- '()
;-- (cons List-Of-Strings List-Of-List-Of-Strings)
;interpretation: an arbitrary large LLS

;String->File
;removes "a" "an" and "the" from n file and saves it to "no-articles" + n
(define (remove-articles n)
    (write-file 
      (string-append "no-articles-" n) 
      (collapse(rm-a (read-words/line n)))
    ))

;LLS->LLS
;removes "a" "an" and "the" from an LLS
(define (rm-a l)
  (cond
    [(empty? l) '()]
    [else (cons (rm-al(first l)) (rm-a (rest l)))]
  )
)

;List-Of-Strings->List-Of-Strings
;removes "an" "a" and "the" from a list of strings
(define (rm-al l)
  (cond
    [(empty? l) '()]
    [else 
      (cond
        [(or
          (string=? (first l) "a")
          (string=? (first l) "an")
          (string=? (first l) "the")
         ) (rm-al (rest l)) ] 
         [else (cons (first l) (rm-al (rest l)))]
      )
    ]
  )
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
