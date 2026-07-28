;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname testing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(check-member-of "green" "red" "yellow" "grey")
;fail because "green" differs from the other elements.
;if we change "grey" by "green" the test pass
(check-member-of "green" "red" "yellow" "green")

(check-within (make-posn #i1.0 #i1.1) (make-posn #i0.9 #i1.2) 0.01)
;fails because first argument is not within 0.1 from the next, and more important,
;you are checking posns and expecting numbers so doesn't work
(check-within 1 1.01 0.01)

(check-range #i1.9 #i0.6 #i0.8)
;fails because the first number isn't between the second and third 
(check-range 5 4 6.6)

(check-random (make-posn (random 3) (random 9)) (make-posn (random 9) (random 3)))
;bro wtf, the problem is that de posn-x and posn-y of the result are swapped 
(check-random (make-posn (random 3) (random 9)) (make-posn (random 3) (random 9)))

(check-satisfied 4 odd?)
;fails because 4 isn't odd
(check-satisfied 5 odd?)
