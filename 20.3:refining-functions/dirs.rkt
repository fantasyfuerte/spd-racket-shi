;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname dirs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require htdp/dir)

(define O 
  (create-dir 
"/Users/macbook/School/año pasado/2do semestre/DPOO/Videos I/Videos I/"))

;a Dir is a structure:
;(make-dir String [List-of Dir] [List-of File])

;Dir -> Number
;determine how many files a directory has
(define (how-many d)
  (+ (length (dir-files d)) 
     (foldr (lambda (a b) (+ (how-many a) b)) 0 (dir-dirs d))))

;Dir String -> Boolean
;determines whether or not a file with name n occur in a directory tree
(check-expect (find? O "terersfsf") #false)
(check-expect (find? O "prueba.txt") #true)
(check-expect (find? O "prueba2.txt") #true)
(define (find? dir name) 
  (cond
    [(empty? (dir-files dir)) #false] 
    [else (or (ormap 
                (lambda (f) (string=? (file-name f) name)) 
                (dir-files dir))
              (ormap (lambda (d) (find? d name)) 
                (dir-dirs dir)))]))

;Dir -> [List-of Strings]
;lists the names of all files and directories in a given dir
(define (ls d)
  (append (map (lambda (d) (dir-name d)) (dir-dirs d)) 
          (map (lambda (f) (file-name f)) (dir-files d))))

;Dir -> Number
;produces the total size of all the files in the directory tree
(define (du d)
  (+ (foldr (lambda (a b) (+ (file-size a) b)) 0 (dir-files d)) 
     (foldr (lambda (a b) (+ (du a) b)) 0 (dir-dirs d))))

;a Path is [List-of String]
;interpretation: directions into a directory tree

;Dir String -> [Path or #false]
;if the file exist returns his path
(define (find dir name) 
  (cond
    [(not(find? dir name)) #false]
    [else (cons (dir-name dir) 
      (if (ormap (lambda (x) (string=? (file-name x) name)) 
                 (dir-files dir)) 
          (cons name '())
          (find (first (filter (lambda (x) (find? x name)) 
                  (dir-dirs dir))) 
                name)))]))

;Dir String -> [List-of Path]
;produces a list of paths with all the occurrences of name
(define (find-all dir name)
  (local (
    (define all-paths 
      (map 
      (lambda (x) (cons (dir-name dir) (find x name))) 
      (dir-dirs dir))) 
    (define list-of-paths (cons (find dir name) all-paths))
    (define res (if (find? dir name) list-of-paths  '())) 
  )
  list-of-paths)
)
