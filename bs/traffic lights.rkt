;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |traffic lights|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;String->Image
;Gives an image of a bulb of c color
(define (bulb c)
  (circle 40 "solid" c)
  )
;State: Integer that represents clock ticks since start
(define (main t)
  (big-bang t
    [to-draw render]
    [on-tick tick-handler]
    ))

;State->Image
;Given a clock tick gives a bulb of a color determined by get-color
;given: 10 expect: (bulb "yellow")
;given: 40 expect: (bulb "red")
;given: 80 expect: (bulb "green")
(define (render x)
  (bulb (get-color x)))
(check-expect (render 10)(bulb "yellow"))
(check-expect (render 40)(bulb "red"))
(check-expect (render 80)(bulb "green"))

;State->String
;Given a clock tick gives color following the next order: YELLOW->RED->GREEN
;given: 10 expects: "yellow"
;given: 40 expects: "red"
;given: 80 expects: "green"
(define (get-color x)
  (cond
    [(<= x 30)"yellow"]
    [(<= x 60)"red"]
    [(<= x 90)"green"]
    [else "black"]
    ))
(check-expect (get-color 10) "yellow")
(check-expect (get-color 40) "red")
(check-expect (get-color 80) "green")

;State->State
;Given a state just add1 unless is 90 in which case returns 0
;given 0 expects 1
;given 4 expects 5
;given 90 expects 0
(define (tick-handler x)
  (if (< x 90) (add1 x) 0))

(check-expect (tick-handler 0) 1)
(check-expect (tick-handler 4) 5)
(check-expect (tick-handler 90) 0)

(main 90)