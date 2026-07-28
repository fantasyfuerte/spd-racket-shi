;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define celestial-bodies 
  (cons "Mercury"
    (cons "Venus"
      (cons "Earth"
        (cons "Mars"
          (cons "Jupyter"
            (cons "Saturn"
              (cons "Uranus"
                (cons "Neptune" '())
))))))))

(define list-of-names (cons "Leo" '()))
;a List-Of-Names is one of :
;-- '()
;-- (cons String List-Of-Names)
;interpretation: a list of invitees, by last name
