;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname add-sierpinski) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Image Posn Posn -> Image
;generative adds the triangle (a, b, c) to s,
;subdivides it into three triangles by taking
;the midpoints of its sides; stop if (a, b, c)
;is too small
(define (add-sierpinski scene0 a b c)
  (cond
    [(too-small? a b c) scene 0]
    [else 
      (local 
        ((define scene1 (add-triangle scene0 a b c))
         (define mid-a-b (mid-point a b))
         (define mid-b-c (mid-point b c))
         (define mid-c-a (mid-point c a))
         (define scene2
           (add-sierpinski scene0 a mid-a-b mid-c-a))
         (define scene3
           (add-sierpinski scene0 b mid-b-c mid-a-b))
         (define scene4 
           (add-sierpinski scene0 c mid-c-a mid-b-c)))
        (... scene1 ... scene2 ... scene3))]))
