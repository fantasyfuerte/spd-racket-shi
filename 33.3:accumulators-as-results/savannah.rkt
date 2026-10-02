;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname savannah) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define MIN 10)
(define LEFT-START 0.3)
(define LEFT-LEN 0.7)
(define LEFT-DEG 12)

(define RIGHT-START 0.7)
(define RIGHT-LEN 0.6)
(define RIGHT-DEG 16)


(define (end-point x y len angle)
  (local ((define deg->radian (* angle (/ pi 180)))
          (define ex (round (* len (inexact->exact (cos deg->radian)))))
          (define ey (round (* len (inexact->exact (sin deg->radian))))))
    (make-posn (+ x ex) (- y ey))))

;Image N N N N -> Image
;adds a savannah tree to the scene
(define (add-savannah scene0 x y len ang)
  (cond
    [(< len MIN) scene0]
    [else
      (local (
              (define end1 (end-point x y len ang))
              (define scene1
                (add-line scene0 x y (posn-x end1) (posn-y end1) 'red))

              (define start-left (end-point x y (* len LEFT-START) ang))
              (define start-right (end-point x y (* len RIGHT-START) ang))
              (define scene2 
                (add-savannah scene1 (posn-x start-left) (posn-y start-left) 
                              (* LEFT-LEN len) (+ ang LEFT-DEG))))
        (add-savannah scene2 (posn-x start-right) (posn-y start-right)
                      (* RIGHT-LEN len) (- ang RIGHT-DEG)))]))

(define SCENE (empty-scene 400 400))
(add-savannah SCENE 200 400 200 90)
