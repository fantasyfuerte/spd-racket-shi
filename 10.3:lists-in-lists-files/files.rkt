;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)

(read-file "ttt.txt")

;a List-Of-Strings is one of:
;--'()
;-- (cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings

(define poem-l (cons "TTT" (cons "" (cons "Put up in a place" (cons "where it's easy to see" '())))))
(define poem-2 (cons "TTT" (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" (cons "where" (cons "it's" (cons "easy" (cons "to" (cons "see" '()))))))))))))
