;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname time-to-seconds) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct time [h m s])
;a Time is a structure
;(make-time NonNegativeNumber NonNegativeNumber NonNegativeNumber)
;(make-time 1 39 8) means 1 hour 39 minutes and 8 seconds

;Seconds are NonNegativeNumbers
;5
;20
;1000

;Time->Seconds
;Given a time computes his seconds
(check-expect (time->seconds (make-time 1 1 40)) 3700)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+ (* 3600 (time-h t)) (* 60 (time-m t)) (time-s t))
)

