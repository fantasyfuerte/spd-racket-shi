;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a File is one of:
;-- '()
;-- (cons "\n" File)
;-- (cons 1String File)
;interpretation: represents the content of a file
;"\n" is the newline character

;a Line is a [List-of 1String]
