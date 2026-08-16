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
