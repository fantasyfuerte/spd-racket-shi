;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname fsm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define-struct transition [current key next])
(define-struct fsm [initial transitions final])

;an FSM is a structure:
;  (make-fsm FSM-State [List-of 1Transition] FSM-State)
;a 1Transition is a structure:
;  (make-transition FSM-State 1String FSM-State)
;an FSM-State is String

;data example:
(define fsm-a-bc*-d
  (make-fsm 
    "AA"
    (list (make-transition "AA" "a" "BC")
          (make-transition "BC" "b" "BC")
          (make-transition "BC" "c" "BC")
          (make-transition "BC" "d" "DD"))
    "DD"))

;FSM String -> Boolean
;does an-fsm recognize the given string
(check-expect (fsm-match? fsm-a-bc*-d "") #false)
(check-expect (fsm-match? fsm-a-bc*-d "aa") #false)
(check-expect (fsm-match? fsm-a-bc*-d "ba") #false)
(check-expect (fsm-match? fsm-a-bc*-d "cd") #false)
(check-expect (fsm-match? fsm-a-bc*-d "ad") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abcd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "acbd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abbbd") #true)
(define (fsm-match? an-fsm a-string)
  (cond
    [(= 0 (string-length a-string)) #false]
    [else 
      (local (
          (define current-state (fsm-initial an-fsm))
          (define current-key (string-ith a-string 0))
          (define final-state (fsm-final an-fsm))
          (define transitions (fsm-transitions an-fsm))

          (define (find-transition t)
            (cond 
              [(empty? t) #false]
              [else (if 
                      (and
                        (string=? current-state 
                                  (transition-current(first t)))
                        (string=? current-key
                                  (transition-key(first t))))
                      (first t)
                      (find-transition (rest t)))]))
          (define transition (find-transition transitions))
          (define (final-state? t)
            (and (= 1 (string-length a-string))
                 (string=? (transition-next t) final-state)))

          (define (possible-transitions ts)
            (local (
                    (define possibles (map 
                                        (lambda (x) 
                                          (transition-next x))
                                        ts)))
              (filter (lambda (x) 
                        (member? 
                          (transition-current x) possibles)) ts))))
    (cond
      [(false? transition) #false]
      [(final-state? transition) #true]
      [else (fsm-match?
              (make-fsm (transition-next transition)
                        (possible-transitions transitions)
                        final-state)
              (substring a-string 1 (string-length a-string)))]))]))
