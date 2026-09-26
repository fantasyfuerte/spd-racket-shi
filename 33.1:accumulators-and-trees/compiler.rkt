;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname compiler) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;a Lam is one of:
;-- a Symbol
;-- (list 'λ (list Symbol) Lam)
;-- (list Lam Lam)

;examples
(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ(x) (x x)) (λ (x) (x x))))

(define (is-var? exp) (symbol? exp))
(define (is-λ? exp) (and (cons? exp)
                        (= (length exp) 3)))
(define (is-app? exp) (and (cons? exp)
                           (= (length exp) 2)))
(define (λ-para exp) (first (second exp)))
(define (λ-body exp) (third exp))
(define (app-fun exp) (first exp))
(define (app-arg exp) (second exp))

;Lam -> [List-of Symbols]
;produces the list of all symbols used as λ parameters in a λ term
(define (declareds exp) 
  (cond
    [(is-var? exp) '()]
    [(is-λ? exp) (cons (λ-para exp) (declareds (λ-body exp)))]
    [else (append (declareds (app-fun exp)) (declareds (app-arg exp)))]))

;; A Lam is one of:
;; – Symbol
;; - λexp
;; - λapp

(define-struct λexp [param body])
;; A λexp is a structure:
;;  (make-struct (list Symbol) Lam)

(define-struct λapp [fun arg])
;; A λapp is a structure:
;;  (make-struct Lam Lam)

;Lam -> Lam
;replaces all symbols s in le with '*undeclared
;if they do not occur within the body of a λ expression
;whose parameter is s
(check-expect (undeclareds ex1) ex1)
(check-expect (undeclareds ex2) '(λ (x) *undeclared))
(check-expect (undeclareds ex3) ex3)
(check-expect (undeclareds ex4) ex4)

(define (undeclareds le0)
  (local
    (;Lam [List-of Symbol] -> Lam
     ;accumulator declareds is a list of all λ parameters
     ;on the path from le0 to  le
     (define (undeclareds/a le declareds)
       (cond
         [(is-var? le)
          (if (member? le declareds) le '*undeclared)]
         [(is-λ? le)
          (local ((define para (λ-para le))
                  (define body (λ-body le))
                  (define newd (cons para declareds)))
            (list 'λ (list para)
                  (undeclareds/a body newd)))]
         [(is-app? le)
          (local ((define fun (app-fun le))
                  (define arg (app-arg le)))
            (list (undeclareds/a fun declareds)
                  (undeclareds/a arg declareds)))])))
    (undeclareds/a le0 '())))
