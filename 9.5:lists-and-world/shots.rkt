;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname shots) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 200)
(define WIDTH 300)
(define X-SHOT (/ WIDTH 2))

(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 20 "solid" "red"))

;a List-Of-Shots is one of:
;-- '() 
;-- (cons SHOT List-Of-Shots)
;interpretation: the collection of shots fired

;a Shot is a Number
;interpretation: represents the shot's y coordinate

;a List-Of-Shots is the state of the world

(define (main x)
  (big-bang '()
    [to-draw render]
    [on-key key-handler]
    [on-tick tick-handler]
  )
)

;List-Of-Shots->Image
;places the shots into BACKGROUND
(define (render l)
  (cond
    [(empty? l) BACKGROUND]
    [else (place-image SHOT X-SHOT (first l) (render(rest l)))]
  )
)

;List-Of-Shots->List-Of-Shots
;computes the next position of the shots after one clock-tick
(define (tick-handler l) 
  (cond
    [(empty? l)l]
    [(empty? (rest l))
        (if (< (first l) 0) '()  (cons (sub1 (first l)) '()))
    ]
    [else (cons (sub1 (first l)) (tick-handler (rest l)))]
  )
)

;List-Of-Shots KeyEvent->List-Of-Shots
;if ke is " " add a new shot to the list
(define (key-handler l ke)
  (cond
    [(string=? ke " ")(cons HEIGHT l)]
    [else l]
  )
)

(main 0)
