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
(check-expect (how-many.v1 m1dir) 7)
(define (how-many.v1 d)
  (cond
    [(empty? d) 0]
    [else (if (string? (first d)) 
          (add1 (how-many.v1 (rest d))) 
          (+ (how-many.v1 (first d)) (how-many.v1 (rest d))))]))

(define-struct dir [name content size readability])

;a Dir.v2 is a structure
; (make-dir String LOFD)

;an LOFD (short for list of files and directories) is one of:
;-- '()
;-- (cons File.v2 LOFD)
;-- (cons Dir.v2 LOFD)

;a File.v2 is a String

(define m2dir 
  (make-dir "TS" 
    (list (make-dir "Text" (list "part1" "part2" "part3") 30 "all") 
          "read" 
          (make-dir "Libs" 
            (list (make-dir "Code" (list "hang" "draw") 40 "all") 
                  (make-dir "Docs" (list "red") 10 "all")) 300 "all"))
            640 "all"))

;Dir.v2 -> Number
;determine how many files a directory has
(check-expect (how-many.v2 m2dir) 7)
(define (how-many.v2 d)
  (cond
    [(empty? (dir-content d)) 0]
    [else (count-lofd (dir-content d))]
  )
)

;LOFD -> Number
(define (count-lofd lofd)
  (cond
    [(empty? lofd) 0]
    [(dir? (first lofd))(+ 
                        (how-many.v2 (first lofd)) 
                        (count-lofd (rest lofd)))]
    [else (add1 (count-lofd (rest lofd)))]
  )
)

(define-struct file [name size content])
;a File.v3 is a structure:
;  (make-file String N String

(define-struct dir.v3 [name dir files])
;a Dir.v3 is a structure:
;(make-dir.v3 String [List-of Dir.v3] [List-of File.v3])

(define m3dir (make-dir.v3 "TS" 
  (list 
    (make-dir.v3 "Text" '() (list 
      (make-file "part1" 99 "")
      (make-file "part2" 52 "")
      (make-file "part3" 17 ""))) 
    (make-dir.v3 "Libs" (list 
      (make-dir.v3 "Code" '() 
        (list (make-file "hang" 8 "") (make-file "draw" 2 "")))
      (make-dir.v3 "Docs" '() (list (make-file "read" 19 "")))) '()))
  (list (make-file "read" 10 ""))))

;Dir.v3 -> Number
;determine how many files a directory has
(check-expect (how-many.v3 m3dir) 7)
(define (how-many.v3 d)
  (+ (length (dir.v3-files d)) 
     (foldr (lambda (a b) (+ (how-many.v3 a) b)) 0 (dir.v3-dir d))))
