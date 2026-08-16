;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname dirs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require htdp/dir)

(define O 
  (create-dir 
"/Users/macbook/School/año pasado/2do semestre/DPOO/Videos I/Videos I/"))

;a Dir.v3 is a structure:
;(make-dir.v3 String [List-of Dir.v3] [List-of File.v3])

;Dir -> Number
;determine how many files a directory has
(define (how-many d)
  (+ (length (dir-files d)) 
     (foldr (lambda (a b) (+ (how-many a) b)) 0 (dir-dirs d))))
