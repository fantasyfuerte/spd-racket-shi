;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname legal) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Posns is one of:
;--'()
;--(cons Posn List-Of-Posns)
;interpretation: an arbitrary large list of posns

;eps stands for example posns list
(define epl (cons (make-posn 1 230)(cons (make-posn 120 0)(cons (make-posn 10 30)(cons (make-posn 3 9) empty)))))

;List-Of-Posns->List-Of-Posns
;computes the posns that are between x [0 , 100] and y [0, 200]
(check-expect (legal epl)(cons (make-posn 10 30) (cons (make-posn 3 9) empty)))
(define (legal l)
  (cond
    [(empty? l) '()]
    [else (cond
      [(and (< 0 (posn-x (first l)) 100)(< 0 (posn-y (first l)) 200)) (cons (first l) (legal (rest l)))]
      [else (legal (rest l))]
    )]
  )
)
