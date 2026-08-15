;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname s-expr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;an S-expr is one of:
;-- Atom
;-- SL

;an Atom is one of:
;-- Number
;-- String
;-- Symbol

;an SL is one of:
;-- '()
;-- (cons S-expr SL)

;Any->Boolean
;yields true if x is an atom
(define (atom? x)
  (or (string? x)
      (number? x)
      (symbol? x)))

;S-expr Symbol -> N
;counts all occurrences of sy in sexp
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)
(define (count sexp sy)
  (cond
    [(atom? sexp)(count-atom sexp sy)]
    [else (count-sl sexp sy)]
  )
)

;SL Symbol -> N
;counts all occurrences of sy in sl
(define (count-sl sl sy)
  (cond
    [(empty? sl) 0]
    [else 
    (+
      (count (first sl) sy)
      (count-sl (rest sl) sy)) 
    ]
  )
)

;Atom Symbol -> N
;counts all occurrences of sy in at
(define (count-atom at sy)
  (cond
    [(number? at) 0]
    [(string? at) 0]
    [(symbol? at) (if (symbol=? at sy) 1 0)]
  )
)
