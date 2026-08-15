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
(define (count sexp sy)
  (local (
    ;SL -> N
    ;counts all occurrences of sy in sl
    (define (count-sl sl)
      (cond
        [(empty? sl) 0]
        [else (+ (count (first sl) sy) (count-sl (rest sl)))]
      )
    )
    ;Atom -> N
    ;verifies if the atom is equal to sy
    (define (count-atom at)
      (cond
        [(number? at) 0]
        [(string? at) 0]
        [(symbol? at) (if (symbol=? at sy) 1 0)]
      )
    )
    
  )
  (cond
    [(atom? sexp) (count-atom sexp)]
    [else (count-sl sexp)]
  ))
)

;S-expr -> N
;produces the depth of the s-expr
(check-expect (depth '(he)) 2)
(check-expect (depth 10) 1)
(check-expect (depth "a") 1)
(check-expect (depth 'x) 1)
(check-expect (depth '()) 1)
(check-expect (depth (cons 10 '())) 2)
(check-expect (depth (cons 10 (cons 5 '()))) 3)
(check-expect (depth (cons (cons 10 '()) '())) 3)
(define (depth sexp)
  (local(
    ;SL->N 
    ;produces the depth of an sl
    (define (depth-sl sl)
      (cond
        [(empty? sl) 1]
        [else (+ (depth (first sl)) (depth-sl (rest sl)))]
      )
    )
  )
  (cond
    [(atom? sexp) 1]
    [else (depth-sl sexp)]
  ))
)

;S-expr Symbol Symbol -> S-expr
;produces an s-expr with all the occurrences of old replaced by new
(check-expect (substitute '(h h (u u)) 'u 'e) '(h h (e e)))
(check-expect (substitute 'old 'old 'new) 'new)
(define (substitute sexp old new)
  (local (
    ;Atom -> Atom
    ;if atoms is a symbol equal to old replace it with new
    (define (sub-atom a) 
      (if (and(symbol? a)(symbol=? a old))new a))
  ) 
  (cond
    [(atom? sexp) (sub-atom sexp)]
    [else (map (lambda (x) (substitute x old new)) sexp)]
  ))  
)
