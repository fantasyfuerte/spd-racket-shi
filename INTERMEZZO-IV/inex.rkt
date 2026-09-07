;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname inex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct inex [mantissa sign exponent])
;an Inex is a structure:
;  (make-inex N99 N99)
;an S is one of:
; -- 1
; -- -1
;an N99 is an N between 0 and 99 (inclusive)

;N Number N -> Inex
;makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "create-inex: invalid arguments")]))

(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
       10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

(define ERR-EXPONENTS "Exponents mismatch.")
(define ERR-RANGE "The result is out of Inex range.")

;Inex Inex -> Inex
;produces the sum of two inexes
(check-expect (inex+ (create-inex 1 1 0) (create-inex 2 1 0))
              (create-inex 3 1 0))
(check-expect (inex+ (create-inex 55 1 0) (create-inex 55 1 0))
              (create-inex 11 1 1))
(check-expect (inex+ (create-inex 56 1 0) (create-inex 56 1 0))
              (create-inex 11 1 1))
(check-expect (inex+ (create-inex 1 -1 0) (create-inex 2 -1 0))
              (create-inex 3 -1 0)) ; 3
(check-expect (inex+ (create-inex 1 -1 1) (create-inex 2 -1 1))
              (create-inex 3 -1 1)) ; 0.3
(check-expect (inex+ (create-inex 1 -1 2) (create-inex 2 -1 2))
              (create-inex 3 -1 2)) ; 0.03
(check-expect (inex+ (create-inex 55 -1 1) (create-inex 55 -1 1))
              (create-inex 11 -1 0))
(check-error (inex+ (create-inex 1 1 0) (create-inex 1 1 1))
             ERR-EXPONENTS)
(check-error (inex+ (create-inex 1 1 0) (create-inex 1 -1 0))
             ERR-EXPONENTS)
(check-error (inex+ (create-inex 99 1 99) (create-inex 1 1 99))
             ERR-RANGE)
(check-error (inex+ (create-inex 55 -1 0) (create-inex 55 -1 0))
             ERR-RANGE)
(check-error (inex+ (create-inex 99 -1 0) (create-inex 1 -1 0))
             ERR-RANGE)
(define (inex+ i1 i2)
  (local (
          (define same-exponents
            (and (= (inex-sign i1) (inex-sign i2))
                 (= (inex-exponent i1) (inex-exponent i2))))

          (define i-sign (inex-sign i1))

          (define i-exp (inex-exponent i1))

          (define mantissa-sum (+ (inex-mantissa i1) (inex-mantissa i2)))

          (define (closest mantissa)
            (local ((define new-mantissa (round (/ mantissa 10)))
                    (define negative-sign? (= -1 i-sign)))
              (cond
                [negative-sign?
                 (local ((define new-exp (- i-exp 1)))
                   (if (< new-exp 0)
                       (error ERR-RANGE)
                       (make-inex new-mantissa i-sign new-exp)))]
                [else
                 (local ((define new-exp (+ i-exp 1)))
                   (if (> new-exp 99)
                       (error ERR-RANGE)
                       (make-inex new-mantissa i-sign new-exp)))]))))
    (if same-exponents
        (if (> mantissa-sum 99)
            (closest mantissa-sum)
            (make-inex mantissa-sum i-sign i-exp))
        (error ERR-EXPONENTS))))

;Inex Inex -> Inex 
;produces the multiplication of two inexes
(check-expect (inex* (create-inex 2 1 0) (create-inex 2 1 0))
              (create-inex 4 1 0))
(check-expect (inex* (create-inex 2 1 0) (create-inex 55 1 0))
              (create-inex 11 1 2))
(define (inex* i1 i2)
  (local(
         (define same-exponents
           (and (= (inex-sign i1) (inex-sign i2))
                (= (inex-exponent i1) (inex-exponent i2))))
         (define i-sign (inex-sign i1))
         (define i-exp1 (inex-exponent i1))
         (define i-exp2 (inex-exponent i2))
         (define mantissa-mul (* (inex-mantissa i1) (inex-mantissa i2)))
         (define i-sum (+ i-exp1 i-exp2))
         ;N -> Inex
         (define (closest mantissa n)
           (if (< mantissa 99)
               (make-inex mantissa i-sign n)
               (closest (round (/ mantissa 10)) (add1 n))))
         )
  (if same-exponents
      (if (> mantissa-mul 99)
          (closest mantissa-mul i-sum)
          (make-inex mantissa-mul i-sign i-sum))
      (error ERR-EXPONENTS))))
