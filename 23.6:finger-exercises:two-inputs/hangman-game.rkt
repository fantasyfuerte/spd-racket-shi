;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname hangman-game) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;an HM-Word is a [List-of Letter or "_"]
;interpretation "_" representsa letter to be guessed

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
