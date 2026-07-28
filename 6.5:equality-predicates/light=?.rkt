;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname light=?) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;TrafficLight if one of:
;-- "green"
;-- "red"
;-- "blue"

;Any->Boolean
;Say if v is a traffic-light
(define (light? v)
  (cond
    [(and(string? v)(or
      (string=? v "green")
      (string=? v "red")
      (string=? v "yellow"))) #true]
    [else #false]
  )
)

;Any Any->Boolean
;Say if the two elements are two equal lights
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-expect (light=? "red" "yellow") #false)
(define (light=? v1 v2) 
  (cond
    [(not(light? v1))(error "first value is not a light")]
    [(not(light? v2))(error "second value is not a light")]
    [else (string=? v1 v2)]
  )
)
