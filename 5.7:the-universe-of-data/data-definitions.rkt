;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname data-definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define PIT [hours minutes seconds])
;A PIT is a structure that means Point In Time
;(make-PIT Number Number Number)

(define pitSM [12am 1am 2am 3am 4am 5am 6am])
;A pitSM is a structure that means points in time Since Midnight
;(make-pitSM PIT PIT PIT PIT PIT PIT PIT)
