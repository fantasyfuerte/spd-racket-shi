;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname interpreter-with-functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define WRONG "an error has occurred")
(define UNKNOWN_VARIABLE "unknown variable")
(define UNKNOWN_TYPE "unknown var type")

;a BSL-expr is one of:
;-- Number
;-- Symbol
;-- Add
;-- Mul

(define-struct add [left right])
;an Add is a structur
; (make-add BSL-expr BSL-expr)
;interpretation: (make-add a b) represents the adition of a and b

(define-struct mul [left right])
;a Mul is a structure 
; (make-mul BSL-expr BSL-expr)
;interpretation: (make-mul a b) means the multiplication of a and b

;a Value is a Number

;BSL-expr -> Value
;computes the value of expr
(check-expect (eval-expression 5) 5)
(check-expect (eval-expression (make-add 2 2)) 4)
(check-expect (eval-expression (make-mul 8 2)) 16)
(check-expect (eval-expression (make-mul (make-add 2 2) 25)) 100)
(define (eval-expression expr)
  (cond
    [(number? expr) expr]
    [(mul? expr) (* (eval-expression (mul-left expr))
                    (eval-expression (mul-right expr)))]
    [(add? expr) (+ (eval-expression (add-left expr))
                    (eval-expression (add-right expr)))]))

;a BSL-bool-expr is one of:
;-- #true
;-- #false
;-- Or
;-- And
;-- Not

(define-struct b-or [left right])
;an Or is a structure:
;  (make-b-or BSL-bool-expr BSL-bool-expr)
;interpretation: represents the or logic operator

(define-struct b-and [left right])
;an And is a structure:
;  (make-b-and BSL-bool-expr BSL-bool-expr)
;interpretation: represents the and logic operator

(define-struct b-not [exp])
;a Not is a structure:
;  (make-b-not BSL-bool-expr)
;interpretation: represents the not logic operator

;a BSL-bool-value is one of:
;-- #true
;-- #false


;BSL-bool-expr -> BSL-bool-value
;computes the value of a bsl bool expression
(check-expect (eval-bool-expression #true) #true)
(check-expect (eval-bool-expression (make-b-or #true #false)) #true)
(check-expect (eval-bool-expression (make-b-not #true)) #false)
(check-expect
  (eval-bool-expression (make-b-or #false (make-b-not #false))) #true)
(define (eval-bool-expression expr)
  (cond
    [(boolean? expr) expr]
    [(b-or? expr) (or (eval-bool-expression (b-or-left expr))
                    (eval-bool-expression (b-or-right expr)))]
    [(b-and? expr) (and (eval-bool-expression (b-and-left expr))
                    (eval-bool-expression (b-and-right expr)))]
    [(b-not? expr) (not (eval-bool-expression (b-not-exp expr)))]
  )
)

;S-expr -> BSl-expr
(check-expect (parse '(+ 1 1)) (make-add 1 1))
(check-expect (parse '(* 20 8)) (make-mul 20 8))
(check-expect (parse '3) 3)
(check-error (parse '((((((hL))))))) WRONG)
(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))

;Atom -> BLS-expr
(define (parse-atom s)
  (cond
    [(number? s) s]
    [else (error WRONG)]
  )
)

;SL -> BSL-expr
(define (parse-sl s)
  (local (
    (define L (length s)))
    (cond
      [(< L 3) (error WRONG)]
      [(and (= L 3) (symbol? (first s)))
         (cond
           [(symbol=? (first s) '+)
              (make-add (parse (second s)) (parse (third s)))]
           [(symbol=? (first s) '*)
              (make-mul (parse (second s)) (parse (third s)))]
           [else (error WRONG)])])))


;S-expr -> Boolean
(define (atom? x) (or (number? x) (string? x) (symbol? x)))

;SL-> [Value or error]
;produces the value of a bsl expression represented as an s-expr
(check-expect (interpreter-expr 5) 5)
(check-expect (interpreter-expr '(+ 3 3)) 6)
(check-expect (interpreter-expr '(* 10 3)) 30)
(check-error (interpreter-expr '(* 3)) WRONG)
(define (interpreter-expr exp)
  (eval-expression (parse exp))
)

;a BSL-var-expr is one of:
;-- Number
;-- Symbol
;-- Add
;-- Mul

;BSL-var-expr Symbol Number -> BSL-expr
;replaces the occurrences of x with v in exp
(check-expect (subst 'x 'x 10) 10)
(check-expect (subst (make-add 3 'r) 'r 40) (make-add 3 40))
(define (subst exp x v)
  (local(
    (define subst-atom
      (cond
        [(equal? exp x) v] 
        [else exp]
      )) 
  )
  (cond
    [(atom? exp) subst-atom]
    [(mul? exp) (make-mul (subst (mul-left exp) x v) 
                          (subst (mul-right exp) x v))]
    [(add? exp) (make-add (subst (add-left exp) x v) 
                          (subst (add-right exp) x v))]
  ))
)

;BSL-var-expr -> Boolean
;determines whether a BSL-var-expr is also a BSL-expr
(check-expect (numeric? (make-add 5 5)) #true)
(check-expect (numeric? (make-add 'y 5)) #false)
(check-expect (numeric? (make-add (make-mul 2 2) 5)) #true)
(check-expect (numeric? (make-add (make-mul 'u 2) 5)) #false)
(define (numeric? expr)
  (cond
    [(atom? expr) (if (symbol? expr) #false #true)]
    [(mul? expr) (and (numeric? (mul-left expr)) 
                      (numeric? (mul-right expr)))]
    [(add? expr) (and (numeric? (add-left expr)) 
                      (numeric? (add-right expr)))]
  )
)

;BSL-var-expr -> [Value or error]
;determines an expression value if this expression is numeric
;otherwise throws an error
(check-expect (eval-variable (make-add 5 5)) 10)
(check-error (eval-variable 'x )UNKNOWN_VARIABLE)
(define (eval-variable exp) 
  (if (numeric? exp) (eval-expression exp) (error UNKNOWN_VARIABLE)) 
)

;an AL (short for association list) is [List-of Association]
;an Association is a list of two items:
;  (list Symbol Number)

;BSL-var-expr AL -> [Value or #false]
;eval the expression if possible otherwise false
(check-expect (eval-variable* (make-add 'x 5) (list (list 'x 2))) 7)
(check-expect (eval-variable* 
              (make-mul 'x 'y) 
              (list 
                (list 'x 8)(list 'y 4))) 32)
(define (eval-variable* ex da)
  (local(
    (define subst-al 
      (foldr (lambda (a b) (subst b (first a) (second a))) ex da)) 
  )
  (eval-variable subst-al))
)

;BSL-var-expr AL -> [Value or #false]
;just search the variables when needed
(check-expect (eval-var-lookup (make-add 'x 5) (list (list 'x 2))) 7)
(check-expect (eval-var-lookup 
              (make-mul 'x 'y) 
              (list 
                (list 'x 8)(list 'y 4))) 32)
(check-error (eval-var-lookup 
              (make-mul 'x 'y) 
              (list 
                (list 'o 8)(list 'y 4))) "undefined variable")
(define (eval-var-lookup ex da)
  (local (
    ;Atom -> [Number or Error]
    (define (sub-atom ex)
      (cond
        [(number? ex) ex]
        [(symbol? ex) (get-value ex da)]
        [else (error UNKNOWN_TYPE)]
      ))
  )
  (cond
    [(atom? ex) (sub-atom ex)]
    [(mul? ex) (*
                 (eval-var-lookup (mul-left ex) da) 
                 (eval-var-lookup (mul-right ex) da))]
    [(add? ex) (+
                 (eval-var-lookup (add-left ex) da) 
                 (eval-var-lookup (add-right ex) da))]
  ))
)

(define (get-value ex da)
  (cond
    [(empty? da) (error "undefined variable")]
    [else 
      (if 
        (symbol=? (first (first da)) ex) 
        (second (first da))
        (get-value ex (rest da)))]
  )
)

;a BSL-var-func-expr is one of:
;-- Number
;-- Symbol
;-- Function
;-- Add
;-- Mul

(define-struct func [name body])
;a Function is a Structure
;  (make-func Symbol BSL-var-func-expr)
;interpretation: (make-func a b) combines the name of the function (a)
;with its body (b)

(define func-ex1 (make-func 'k (make-add 1 1)))
(define func-ex2 (make-mul- 5 func-ex1))
(define func-ex3 (make-mul (make-func 'i 5) func-ex1))
