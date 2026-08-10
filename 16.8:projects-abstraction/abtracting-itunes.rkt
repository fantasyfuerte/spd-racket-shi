;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname abtracting-itunes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/batch-io)
(require 2htdp/itunes)

(define IL "itunes.xml")

;LTracks
(define itunes-tracks
  (read-itunes-as-tracks IL))

;a Date is a structure
;  (make-date N N N N N N)
;interpretations: year month day hour minute second
;example: (make-date 2026 8 2 13 44 40)

;a Track is a structure
;  (make-track String String String  N N Date N Date)
;interpretation: title,artist, album, playing time, position in album,
;date it was added, played times, date when kt was last played
;example: (make-track 
;  "Wild Child" 
;  "Enya" 
;  "A Day Without Rain" 
;  227996 
;  2 
;  (make-date 2002 7 17 3 55 14) 
;  20 
;  (make-date 2011 5 17 17 35 13))

;a List-Of-Strings is one of:
;--'()
;--(cons String List-Of-Strings)
;interpretation: an arbitrary large list of strings

(define-struct agroup [album tracks])
;an AlbumGroup is a structure:
;  (make agroup [String LTracks])
;interpretation: (make-agroup n l) means
;that the album n has a list l of tracks

;a [List-Of ITEM] is one of:
;-- '()
;-- (cons ITEM [List-of ITEM])

;LTracks->[List-of AlbumGroup]
;Given a list of tracks return a list of AlbumGroup
(define (select-albums l)
  (cond
    [(empty? l) '()]
    [else (cons 
      (make-agroup 
        (track-album (first l)) 
        (select-album (track-album (first l)) l))  
      (select-albums (remove-album (track-album (first l))(rest l))))
    ]
 ) 
)

;String LTracks->LTracks
;deletes the tracks who belongs to certain album
(define (remove-album a l)
  (cond
    [(empty? l) '()]
    [else (cond
        [(string=? a (track-album (first l))) (remove-album a (rest l))]
        [else (cons (first l) (remove-album a (rest l)))]
      )
    ]
  )
)

;String LTracks->LTracks
;returns the tracks of a album
(define (select-album-date a l d)
  (cond
    [(empty? l) '()]
    [else 
      (cond
        [(and 
          (string=? a (track-album (first l)))
          (is-after (track-played (first l)) d))
          (cons (first l) (select-album-date a (rest l) d))]
        [else (select-album-date a (rest l) d)]  
      )
    ]
  )
)

;Date Date->Boolean
;yields true if d1 is after d2
(define (is-after d1 d2)
  (cond
    [(>(date-year d1) (date-year d2)) #true]
    [(<(date-year d1) (date-year d2)) #false]
    [(>(date-month d1) (date-month d2)) #true]
    [(<(date-month d1) (date-month d2)) #false]
    [(>(date-day d1) (date-day d2)) #true]
    [(<(date-day d1) (date-day d2)) #false]
    [(>(date-hour d1) (date-hour d2)) #true]
    [(<(date-hour d1) (date-hour d2)) #false]
    [(>(date-minute d1) (date-minute d2)) #true]
    [(<(date-minute d1) (date-minute d2)) #false]
    [(>(date-second d1) (date-second d2)) #true]
    [(<(date-second d1) (date-second d2)) #false]
  )
)

;String LTracks->LTracks
;given returns the tracks of a album
(define (select-album a l)
  (cond
    [(empty? l) '()]
    [else 
      (cond
        [(string=? a (track-album (first l)))
          (cons (first l) (select-album a (rest l)))]
        [else (select-album a (rest l))]  
      )
    ]
  )
)

;Track->Number
;given a track produces its playing time in milliseconds
(define (total-time t)
  (* (track-time t) (track-play# t))
)

;LTracks->Number
;given a list of tracks produces its total playing time in milliseconds
(define (time-wasted l)
  (cond
    [(empty? l) 0]
    [else (+ (total-time (first l)) (time-wasted (rest l)))]
  )
)

;LTracks->[List-of String]
;given a list of tracks returns a list of all album titles
(define (select-all-album-titles l)
  (cond 
    [(empty? l) '()]
    [else (cons (track-album (first l)) (select-all-album-titles (rest l)))]
  )
)

;LTracks->[List-of String]
;given a list of tracks returns a list of all album titles without repeating
;any album
(define (select-all-album-titles/unique l)
  (create-set (select-all-album-titles l))
)

;[List-of String]->[List-of String]
;removes repeated strings
(check-expect
  (create-set (list "1" "2" "3"))
  (list "1" "2" "3"))
(check-expect
  (create-set (list "1" "1" "2" "3"))
  (list "1" "2" "3"))
(define (create-set l)
  (cond
    [(empty? l) '()]
    [else
      (cond 
        [(member? (first l) (create-set (rest l))) (create-set (rest l))]
        [else (cons (first l) (create-set (rest l)))]
      )
    ]
  )
)

(select-all-album-titles/unique itunes-tracks)
