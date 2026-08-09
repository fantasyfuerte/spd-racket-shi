;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname is-close) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;[List-of Posn] Posn ->Boolean
;determines if any posn of l is close to p
(check-expect
  (is-close (list (make-posn 0 0)) (make-posn 100 100))
  #false)
(check-expect
  (is-close (list (make-posn 96 0)) (make-posn 100 100))
  #false)
(check-expect
  (is-close (list (make-posn 96 99)) (make-posn 100 100))
  #true)
(define (is-close l p)
  (local (
    ;Posn Posn->Number
    ;calculates the distance between a and b
    (define (distance-between a b)
      (sqrt(+(sqr(- (posn-x a) (posn-x b)))(sqr(- (posn-y a) (posn-y b)))))
    )
    ;Posn->Boolean
    ;yields true if pa is close to p
    (define (5pxclose? pa)
      (>= 5 
      (distance-between pa p))
    )
  )(ormap 5pxclose? l))
)
