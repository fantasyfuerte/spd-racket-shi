;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hangman-game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

;an HM-Word is a [List-of Letter or "_"]
;interpretation "_" representsa letter to be guessed

(define LETTERS (explode "abcdefghijklmnñopqrstuvwxyz"))
(define (do-nothing s ) s)

;HM-Word N -> String
;runs a simplistic hangman game, produces the current state
(define (play the-pick time-limit)
  (local ((define the-word (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          ;HM-Word -> HM-Word
          (define (do-notheing s) s)
          ;HM-Word KeyEvent -> HM-Word
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status)))
    (implode
      (big-bang the-guess ; HM-Word
        [to-draw render-word]
        [on-tick do-nothing 1 time-limit]
        [on-key checked-compare]))))

;HM-Word -> Image
(define (render-word w)
  (text (implode w) 22 "black"))

;HM-Word HM-Word KeyEvent -> HM-Word
;produces guess with all the "_" where k revealed a letter
(check-expect 
  (compare-word '("d" "o" "g") '("_" "_" "g") "o") '("_" "o" "g"))
(check-expect 
  (compare-word '("d" "o" "g") '("_" "_" "g") "t") '("_" "_" "g"))
(define (compare-word the-word guess k)
  (cond
    [(not(member? "_" guess)) guess]  
    [else 
      (if (and (blank? (first guess)) (equal? (first the-word) k))
          (cons (first the-word) 
                (compare-word (rest the-word) (rest guess) k))
          (cons (first guess)
                (compare-word (rest the-word) (rest guess) k)))]))

;String -> Boolean
;yields true if s is "_"
(define (blank? x) (string=? "_" x))

(define LOCATION "/usr/share/dict/words")
(define AS-LIST (read-lines LOCATION))
(define SIZE (length AS-LIST))
(play (list-ref AS-LIST (random SIZE)) 60)
