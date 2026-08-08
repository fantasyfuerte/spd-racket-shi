;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname smallest-and-largest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;Nelon->Number
;determines the smallest number on l
(define (inf l)
  (cond
    [(empty? (rest l))
      (first l)]
    [else 
      (if (< (first l) (inf (rest l))) 
        (first l) 
        (inf (rest l))) 
    ]
  )
)

;Nelon->Number
;determines the largest number on l
(define (sup l)
  (cond
    [(empty? (rest l))
      (first l)]
    [else 
      (if (> (first l) (sup (rest l))) 
        (first l) 
        (sup (rest l))) 
    ]
  )
)

(define (find R l)
  (cond
    [(empty? (rest l))
      (first l)]
    [else 
      (if (R (first l) (find R (rest l))) 
        (first l) 
        (find R (rest l))) 
    ]
  )
)
