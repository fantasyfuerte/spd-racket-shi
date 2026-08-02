;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname itunes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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
