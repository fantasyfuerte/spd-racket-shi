;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname design-recipe-drawind-red-circles) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Problem: define a function that places small red circles on a 200x200 canvas 
;for a given list of Posns.

(require 2htdp/image)

(define MT-SCENE (empty-scene 200 200))
(define DOT (circle 5 "solid" "red"))

[List-of Posn] -> Image
;adds the Posns on l to the empty scene
(define (dots l) MT-SCENE)
