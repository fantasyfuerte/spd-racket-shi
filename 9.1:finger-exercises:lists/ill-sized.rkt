;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ill-sized) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;a List-Of-Images is one of:
;--"()
;-- (cons Image List-Of-Images)
;interpretation: an arbitrary large list of images

;ImageOrFalse is one of:
;-- Image 
;-- #false

(define img1 (rectangle 5 5 "solid" "red"))
(define img2 (rectangle 5 5 "solid" "red"))
(define img3 (rectangle 5 5 "solid" "red"))
(define img4 (rectangle 3 1 "solid" "red"))

;List-Of-Images->ImageOrFalse
;produces the first image on l that is not an n by n square
;if not produces #false
(check-expect (ill-sized? '() 4) #false)
(check-expect (ill-sized? (cons img1 (cons img2 (cons img3 '()))) 5) #false)
(check-expect (ill-sized? (cons img1 (cons img2 (cons img3 (cons img4 '())))) 5) img4)
(check-expect (ill-sized? (cons img1 (cons img2 (cons img3 '()))) 4) img1)
(define (ill-sized? l n)
  (cond
    [(empty? l) #false]
    [(and
      (= n(image-width (first l)))
      (= n (image-height (first l)))
     ) (ill-sized? (rest l) n)
    ]
    [else (first l)]
  )
)
