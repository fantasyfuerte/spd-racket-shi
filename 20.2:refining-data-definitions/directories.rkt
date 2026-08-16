;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname directories) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a Dir.v1 (short for directory) is one of:
;-- '()
;-- (cons File.v1 Dir.v1)
;-- (cons Dir.v1 Dir.v1)

;a File.v1 is a String

;exercise 330
(define m1dir 
  (list 
    (list "part1" "part2" "part3") 
    "read"
    (list 
      (list "hang" "draw") 
      (list "read"))))

;Dir.v1 -> Number
;determines how many file a directory has
(check-expect (how-many m1dir) 7)
(define (how-many d)
  (cond
    [(empty? d) 0]
    [else (if (string? (first d)) 
          (add1 (how-many (rest d))) 
          (+ (how-many (first d)) (how-many (rest d))))]))

(define-struct dir [name content])

;a Dir.v2 is a structure
; (make-dir String LOFD)

;an LOFD (short for list of files and directories) is one of:
;-- '()
;-- (cons File.v2 LOFD)
;-- (cons Dir.v2 LOFD)

;a File.v2 is a String

(define m2dir 
  (make-dir "TS" 
    (list (make-dir "Text" (list "part1" "part2" "part3)) 
          "read" 
          (make-dir "Libs" 
            (list (make-dir "Code" (list "hang" "draw")) 
                  (make-dir "Docs" (list "red")))))))
