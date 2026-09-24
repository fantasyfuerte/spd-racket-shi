;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname editor-with-mouse) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define FONT-SIZE 11)
(define FONT-COLOR "black")

;[List-of 1String] -> Image
;renders a string as an image for the editor
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))

(define-struct editor [pre post])
;an editor is a structure 
;  (make-editor [List-of 1String] [List-of 1String])
;interpretation: if (make-editor p s) is the state of 
;an interactive editor, (reverse p) corresponds to
;the text to the left of the cursor and s to the text on the right


