;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
;an Editor is a structure
; (make-editor Lo1S Lo1S)
;a Lo1S is one of:
;-- '()
;-- (cons 1String Lo1S)

(define good (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all (cons "a" (cons "l" (cons "l" '()))))
(define lla (cons "l" (cons "l" (cons "a" '()))))

;data example 1:
(make-editor all good)

;data example 2:
(make-editor lla good)

(define HEIGHT 40)         ; the height of the editor
(define WIDTH 400)         ; its width
(define FONT-SIZE 26)      ; the font size
(define FONT-COLOR "black") ; the font color

(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 4 HEIGHT "solid" "skyblue"))

;main : String->Editor
;launches the editor given some initial string
(define (main s)
  (big-bang (create-editor s "")
    [on-key editor-key-handler]
    [to-draw editor-render]
  )
)

;Editor->Image
;renders an editor as an image of the two texts
;separated by the cursor
(define (editor-render e)
  (place-image/align
    (beside 
      (text (append-line (reverse(editor-pre e))) FONT-SIZE FONT-COLOR)
      CURSOR
      (text (append-line (editor-post e)) FONT-SIZE FONT-COLOR)
    )
  1 1
  "left" "top" MT)
)

;Editor KeyEvent -> Editor
;deals with a key event, given some editor
(check-expect (editor-key-handler 
              (create-editor "" "") "a")
(create-editor "a" ""))
(check-expect (editor-key-handler 
              (create-editor "ab" "defg") "c")
(create-editor "abc" "defg"))
(check-expect (editor-key-handler 
              (create-editor "ab" "defg") "\b")
(create-editor "a" "defg"))
(check-expect (editor-key-handler 
              (create-editor "ab" "defg") "right")
(create-editor "abd" "efg"))
(check-expect (editor-key-handler 
              (create-editor "a" "") "right")
(create-editor "a" ""))
(check-expect (editor-key-handler 
              (create-editor "" "a") "\b")
(create-editor "" "a"))
(define (editor-key-handler e ke)
  (cond
    [(key=? ke "left") (editor-left e)]
    [(key=? ke "right") (editor-right e)]
    [(key=? ke "\b") (editor-del e)]
    [(key=? ke "\t") e]
    [(key=? ke "\r") e]
    [(= (string-length ke) 1) (editor-insert e ke)]
    [else e]
  )
)

;Editor 1String->Editor
;insert k at the end of pre 
(check-expect
  (editor-insert (make-editor '() '()) "e")
  (make-editor (cons "e" '()) '()))
(define (editor-insert e k)
  (make-editor (cons k (editor-pre e)) (editor-post e))
)

;Editor->Editor
;moves the cursor position 1String to the left,
;if possible
(check-expect (editor-left (create-editor "" "")) (create-editor "" ""))
(check-expect 
  (editor-left (create-editor "123" "456"))
  (create-editor "12" "3456"))
(define (editor-left e)
  (cond 
    [(empty? (editor-pre e)) e]
    [else (make-editor 
      (rest (editor-pre e)) 
      (cons (first (editor-pre e)) (editor-post e)))]
  )
)

;Editor->Editor
;moves the cursor position 1String to the right,
;if possible
(check-expect (editor-right (create-editor "" "")) (create-editor "" ""))
(check-expect 
  (editor-right (create-editor "123" "456"))
  (create-editor "1234" "56"))
(define (editor-right e)
  (cond 
    [(empty? (editor-post e)) e]
    [else (make-editor 
      (cons (first (editor-post e)) (editor-pre e)) 
      (rest (editor-post e))
      )]
  )
)

;Editor->Editor
;deletes the first 1String of (editor-pre e)
(check-expect (editor-del (create-editor "" "")) (create-editor "" ""))
(check-expect (editor-del (create-editor "aaa" "b")) (create-editor "aa" "b"))
(define (editor-del e)
  (cond
    [(empty? (editor-pre e)) e]
    [else (make-editor (rest (editor-pre e)) (editor-post e))]
  )
)

;String String->Editor
;produces an editor using this strings
(define (create-editor pre post)
  (make-editor (rev(explode pre)) (explode post))
)

;Lo1S->Lo1S
;produces a reverse version of the given list
(check-expect (rev all) lla)
(check-expect (rev (cons "h" (cons "e" '()))) (cons "e" (cons "h" '())))
(define (rev l)
  (cond 
    [(empty? l) '()]
    [else (add-at-end(rev (rest l)) (first l))]
  )
)

;Lo1S String->Lo1S
;adds a s to the end of l
(check-expect (add-at-end 
              (cons "h" (cons "2" '()))
              "O")
(cons "h" (cons "2" (cons "O" '()))))
(define (add-at-end l s)
  (cond 
    [(empty? l) (cons s '())]
    [else (cons (first l) (add-at-end(rest l) s))]
  )
)

;List-Of-Strings->String
;produces a string from a list of strings
(define (append-line l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (append-line (rest l)))]
  )
)

(main "hello")
