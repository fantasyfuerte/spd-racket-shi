;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname collapse) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

;a List-Of-Strings is one of:
;--'()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings


;a List-Of-List-Of-Strings (LLS) is one of:
;-- '()
;-- (cons List-Of-Strings List-Of-List-Of-Strings)
;interpretation: an arbitrary large LLS

;LLS->String
;produces a string with all the content of the file
(check-expect (collapse (read-words/line "ttt.txt")) (read-file "ttt.txt"))
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
