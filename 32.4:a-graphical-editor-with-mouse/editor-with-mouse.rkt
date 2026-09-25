;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname editor-with-mouse) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

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

;[List-of 1String] -> N 
;produces an editor with the cursor at the mouse x-coordinate
(define (split-structural ed x)
  (local (
          (define (are-ok? pre post)
            (and (<= (image-width (editor-text pre)) x)
                 (or 
                   (empty? post)
                   (<= x (image-width (editor-text (cons (first post) pre)))))))
          (define (split-structural* pre post)
            (cond
              [(empty? pre ) (make-editor '() ed)]
              [(are-ok? pre post) (make-editor pre post)]
              [else (split-structural* (rest pre) 
                                       (cons (first pre) post))])))
    (split-structural* (reverse ed) '())))

(define (split ed x)
  (local (
          (define (preok? x) 
            (<= (image-width (editor-text pre)) x))
          ;[List-of 1String] [List-of 1String] -> Editor
          ;accumulator apost is the post of the editor
          (define (split/a pre apost)
            (cond
              [(empty? pre) (make-editor '() ed)]
              [(preok? pre) (make-editor pre apost)]
              [else (split/a (rest pre) (cons (first pre) apost))])))
    (split/a (reverse ed) '())))
