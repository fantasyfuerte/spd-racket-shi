;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname subst-to-simplify) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Any->Boolean
;yields true if x is an atom
(define (atom? x)
  (or (string? x)
      (number? x)
      (symbol? x)))


;S-expr Symbol Atom -> S-expr
;replaces all occurrences of old in sexp with new
(check-expect 
  (substitute '(((world) bye ) bye) 'bye '42)
  '(((world) 42) 42))
(define (substitute sexp old new)
  (local (;S-expr->S-expr
          (define (for-sexp sexp)
            (cond
              [(atom? sexp) (for-atom sexp)]
              [else (for-sl sexp)]))
          ;SL -> S-expr
          (define (for-sl sl) (map for-sexp sl))
          ;Atom -> S-expr
          (define (for-atom at)
            (cond
              [(number? at) at]
              [(string? at) at]
              [(symbol? at) (if (equal? at old) new at)])))
    (for-sexp sexp)))
