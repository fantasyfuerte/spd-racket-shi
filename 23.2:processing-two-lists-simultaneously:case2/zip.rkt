;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname zip) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct phone-record [name number])
;a PhoneRecord is a structurea:
;  (make-phone-record String String)
(check-expect
  (zip 
    '("leo" "micah" "john")
    '("555" "444" "111"))
  (list
    (make-phone-record "leo" "555")
    (make-phone-record "micah" "444")
    (make-phone-record "john" "111")))
(define (zip ln lpn)
  (cond
    [(empty? ln) '()]
    [else (cons 
      (make-phone-record (first ln) (first lpn)) 
      (zip (rest ln) (rest lpn)))]
  )
)
