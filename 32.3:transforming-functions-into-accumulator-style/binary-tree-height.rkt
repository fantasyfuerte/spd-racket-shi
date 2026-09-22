;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname binary-tree-height) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct node [left right])
;a Tree is one of:
;-- '()
;-- (make-node Tree Tree)
(define example
  (make-node 
    (make node 
          '() 
          (make-node 
            '() 
            '())) 
    '()))
