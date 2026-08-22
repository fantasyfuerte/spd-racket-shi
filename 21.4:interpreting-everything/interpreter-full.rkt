;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname interpreter-full) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define NOT_FOUND "definition not found")
(define WRONG_EXPR "invalid expression")

;a BSL-var-func-expr is one of:
;-- Number
;-- Symbol
;-- Function
;-- Add
;-- Substract
;-- Mul
;-- Divide

(define-struct add [left right])
;an Add is a structure
; (make-add BSL-expr BSL-expr)
;interpretation: (make-add a b) represents the adition of a and b

(define-struct mul [left right])
;a Mul is a structure 
; (make-mul BSL-expr BSL-expr)
;interpretation: (make-mul a b) means the multiplication of a and b

(define-struct substract [left right])
;a Substract is a structure
; (make-substract BSL-expr BSL-expr)
;interpretation: (make-substract a b) represents the substraction 
;of a and b

(define-struct divide [left right])
;a Divide is a structure
; (make-divide BSL-expr BSL-expr)
;interpretation: (make-divide a b) represents the division 
;of a and b

;a Value is a Number

(define-struct func [name arg])
;a Function is a Structure
;  (make-func Symbol BSL-var-func-expr)
;interpretation: (make-func a b) combines the name of the function (a)
;with its argument

(define-struct cons-def [name value])
;a ConstantDefinition is a structure:
;  (make-cons-def Symbol BSL-expr)
;interpretation: (make-cons-def a b) combines the name (a) 
;and its value (b)

(define-struct func-def [name arg body])
;a FunctionDefinition is a structure:
;  (make-func-def Symbol Symbol BSL-expr)
;interpretation: (make-func-def a b c) combines the function a with
;parameter b and body c

;a Definition is one of:
;-- ConstantDefinition
;-- FunctionDefinition

;a BSL-da-all is a [List-of Definition]

;BSL-da-all Symbol -> ConstantDefinition
;produces the representation of a constant definition
;otherwise throws an error
(check-error (lookup-cons-def '() 't) NOT_FOUND)
(check-expect 
  (lookup-cons-def (list (make-cons-def 'x 50) 
                        (make-func-def 'get 'x (make-add 'x 3))) 'x) 
  (make-cons-def 'x 50))
(define (lookup-cons-def da x)
  (cond
    [(empty? da) (error NOT_FOUND)]
    [else (if (and (cons-def? (first da)) 
                   (symbol=? x (cons-def-name (first da))))
          (first da)
          (lookup-cons-def (rest da) x))]))

;BSL-da-all Symbol -> FunctionDefinition
;produces the representation of a function definition
;otherwise throws an error
(check-error (lookup-func-def '() 't) NOT_FOUND)
(check-expect 
  (lookup-func-def (list (make-cons-def 'x 50) 
                        (make-func-def 'get 'x (make-add 'x 3))) 'get) 
  (make-func-def 'get 'x (make-add 'x 3)))
(define (lookup-func-def da f)
  (cond
    [(empty? da) (error NOT_FOUND)]
    [else (if (and (func-def? (first da))
                   (symbol=? f (func-def-name (first da))))
          (first da)
          (lookup-func-def (rest da) f))]))

;BSL-expr BSL-da-all -> Value
;evaluates the expression with the da data
(check-expect (eval-all (make-add 3 3) '()) 6)
(check-expect 
  (eval-all (make-add 'age 3) (list (make-cons-def 'age 10))) 13)
(check-expect
  (eval-all (make-add (make-func 'age 8) 3) 
            (list (make-func-def 'age 'x (make-add 'x 10))))
  21)
(define (eval-all exp da)
  (cond
    [(number? exp) exp] 
    [(add? exp) (+ (eval-all (add-left exp) da)
                   (eval-all (add-right exp) da))]
    [(substract? exp) (- (eval-all (substract-left exp) da)
                   (eval-all (substract-right exp) da))]
    [(mul? exp) (* (eval-all (mul-left exp) da)
                   (eval-all (mul-right exp) da))]
    [(divide? exp) (/ (eval-all (divide-left exp) da)
                   (eval-all (divide-right exp) da))]
    [(symbol? exp) (eval-all (cons-def-value (lookup-cons-def da exp))
                    da)]
    [(func? exp) (local(
      (define f (lookup-func-def da (func-name exp)))
      (define arg-val (eval-all (func-arg exp) da))
      (define plugd (subst (func-def-body f) 
                           (func-def-arg f) 
                            arg-val))) 
    (eval-all plugd da))]))

;S-expr -> Boolean
(define (atom? x) (or (number? x) (string? x) (symbol? x)))

;BSL-var-expr Symbol Number -> BSL-expr
;replaces the occurrences of x with v in exp
(check-expect (subst 'x 'x 10) 10)
(check-expect (subst (make-add 3 'r) 'r 40) (make-add 3 40))
(define (subst exp x v)
  (local(
    (define subst-atom
      (cond
        [(equal? exp x) v] 
        [else exp])))
  (cond
    [(atom? exp) subst-atom]
    [(mul? exp) (make-mul (subst (mul-left exp) x v) 
                          (subst (mul-right exp) x v))]
    [(add? exp) (make-add (subst (add-left exp) x v) 
                          (subst (add-right exp) x v))])))

;S-expr -> BSl-expr
(check-expect (parse '(+ 1 1)) (make-add 1 1))
(check-expect (parse '(* 20 8)) (make-mul 20 8))
(check-expect (parse '3) 3)
(check-error (parse '((((((hL))))))) WRONG_EXPR)
(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))

;Atom -> BLS-expr
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(symbol? s) s]
    [else (error WRONG_EXPR)]
  )
)

;SL -> BSL-expr
(define (parse-sl s)
  (local (
    (define L (length s)))
    (cond
      [(= L 2) (make-func (first s) 
                            (parse (second s)))]
      [(< L 3) (error WRONG_EXPR)]
      [(and (= L 3) (symbol? (first s)))
         (cond
           [(symbol=? (first s) '+)
              (make-add (parse (second s)) (parse (third s)))]
           [(symbol=? (first s) '-)
              (make-substract (parse (second s)) (parse (third s)))]
           [(symbol=? (first s) '*)
              (make-mul (parse (second s)) (parse (third s)))]
           [(symbol=? (first s) '/)
              (make-divide (parse (second s)) (parse (third s)))]
           [else WRONG_EXPR])])))

;SL -> BSL-da-all
;parses the definitions area 
(define (parse-def s)
  (cond
    [(empty? s) '()]
    [(equal? (first s) 'define) 
        (if (symbol? (second s)) 
            (make-cons-def (second s) (parse (third s)))
            (make-func-def (first (second s)) 
                           (second (second s))
                           (parse (third s))))]))

;S-expr SL -> Value
;interprets an s-expr as bsl
(check-expect (interpreter '(+ 3 3) '()) 6)
(check-expect 
  (interpreter '(+ x (age 10)) 
    '((define x 10) (define (age x) 18)))
  28)
(define (interpreter sexp sl)
  (eval-all (parse sexp) (map parse-def sl))
)
