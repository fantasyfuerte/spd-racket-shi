;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname add-sierpinski) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

(define ab-side-threshold 10)

;Image Posn Posn -> Image
;generative adds the triangle (a, b, c) to s,
;subdivides it into three triangles by taking
;the midpoints of its sides; stop if (a, b, c)
;is too small
(define (add-sierpinski scene0 a b c)
  (cond
    [(too-small? a b c) scene0]
    [else 
      (local 
        ((define scene1 (add-triangle scene0 a b c))
         (define mid-a-b (mid-point a b))
         (define mid-b-c (mid-point b c))
         (define mid-c-a (mid-point c a))
         (define scene2
           (add-sierpinski scene1 a mid-a-b mid-c-a))
         (define scene3
           (add-sierpinski scene2 b mid-b-c mid-a-b))
         (define scene4 
           (add-sierpinski scene0 c mid-c-a mid-b-c)))
        (add-sierpinski scene3 c mid-c-a mid-b-c))]))

;Image Posn Posn Posn -> Image
;adds the black triangle a b c to scene
(define (add-triangle scene a b c)
  (scene+line 
    (scene+line
      (scene+line scene (posn-x a) (posn-y a) (posn-x b) (posn-y b) "black")
      (posn-x b) (posn-y b) (posn-x c) (posn-y c) "black")
    (posn-x c) (posn-y c) (posn-x a) (posn-y a) "black"))

;Posn Posn Posn -> Boolean
;is the triangle a b c too small to be divided?
(define (too-small? a b c)
  (< (sqrt (+ (sqr (- (posn-x a) (posn-x b))) 
              (sqr (- (posn-y a) (posn-y b))))) 
     ab-side-threshold))

;Posn Posn -> Posn
;determines the midpoint between a and b
(define (mid-point a b)
  (make-posn (/ (+ (posn-x a) (posn-x b)) 2) 
             (/ (+ (posn-x a) (posn-x b)) 2)))

