;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname graphical-editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
;an Editor is a structure
; (make-editor String String)
; (make-editor s t) describes an editor 
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define MTS (empty-scene 300 100))
(define (ctext s) (text s 20 "black"))

(define (run p)
  (big-bang (make-editor p "")
    [to-draw render]
    [on-key key-handler]
  )
)

;Editor->Image
;Given an editor creates an image with the editor text in it
(define (render e) 
  (overlay/align "left" "center" 
    (beside  
      (ctext (editor-pre e))
      (rectangle 5 20 "solid" "grey")
      (ctext (editor-post e))
    )
   MTS)
)

;Editor KeyEvent->Editor
;KeyEvent is one of:
;--right
;--left
;--\b
;-- [every letter]
(check-expect (key-handler (make-editor "123" "456") "a")(make-editor "123a" "456"))
(check-expect (key-handler (make-editor "123" "456") "left")(make-editor "12" "3456"))
(check-expect (key-handler (make-editor "123" "456") "right")(make-editor "1234" "56"))
(check-expect (key-handler (make-editor "123" "456") "\b")(make-editor "12" "456"))
(define (key-handler e ke) 
  (cond
    [(or(string=? ke "left")(string=? ke "right"))(move-cursor e ke)]
    [(string=? ke "\b")(delchar e)]
    [(or(string=? ke "\t")(string=? ke "\r"))e]
    [else (writechar e ke)]
  )
)

;Editor String->Editor
;move the cursor to "left" or "right" direction if possible
(define (move-cursor e direction) 
  (cond
    [(string=? direction "left")(if(<= (string-length (editor-pre e)) 0) e 
      (make-editor 
        (substring (editor-pre e) 0 (sub1 (string-length (editor-pre e))))
        (string-append (substring (editor-pre e) (sub1(string-length (editor-pre e))) (string-length (editor-pre e))) (editor-post e))
      )
    )]
    [(string=? direction "right") (if(<= (string-length (editor-post e)) 0) e 
      (make-editor
        (string-append (editor-pre e) (substring (editor-post e) 0 1))
        (substring (editor-post e) 1 (string-length (editor-post e)))
      )
    )]
  )
)

;Editor->Editor
;Delete the last character of (editor-pre e) if any
(define (delchar e)
  (if(<= (string-length(editor-pre e)) 0)e 
    (make-editor 
      (substring (editor-pre e) 0 (sub1(string-length (editor-pre e))))
      (editor-post e)
    )
  )
)

;Editor 1String->Editor
;writes a character
(define (writechar e c) 
  (make-editor
    (string-append (editor-pre e) c)
    (editor-post e)
  )
)


