;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname wage-for-h-hours) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a List-Of-Numbers is one of:
;-- '()
;-- (cons Number List-Of-Numbers)
;interpretation: an arbitrary large list of numbers

;Number->Number
;computes the wage of an employe in h hours
(check-expect (wage 10) 120)
(check-expect (wage 5) 60)
(define (wage h)
  (* 12 h)
)

(define ex-list (cons 10 (cons 10 (cons 8 (cons 4 empty)))))

;List-Of-Numbers->List-Of-Numbers
;computes the wages of all workers
(check-expect (wage* ex-list) (cons (* 10 12) (cons (* 10 12) (cons (* 8 12) (cons (* 4 12) empty)))))
(define (wage* l)
  (cond
    [(empty? l) empty]
    [else (cons (wage (first l)) (wage* (rest l)))]
  )
)
