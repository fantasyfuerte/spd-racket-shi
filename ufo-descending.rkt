;
;
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ufo-descending) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
;State: number that represents pixels between background's top margin and the UFO

(define WIDTH 800); distances in term of pixels
(define HEIGHT 300)
(define CLOSE (/ HEIGHT 3))
(define SCENE (empty-scene WIDTH HEIGHT))
(define UFO (overlay (circle 10 'solid 'green) (rectangle 40 5 'solid 'red)))
(define SCENE-UFO-CENTER (- (/ WIDTH 2) (/ (image-width UFO) 2)))
(define LANDING-COORDINATE (- HEIGHT (/ (image-height UFO) 2)))


(define (main y0)
  (big-bang y0
    [to-draw render]
    [on-tick next]
 ))

;State->State
;Computes the next location for UFO
(check-expect (next 10) 13)
(check-expect (next 0) 3)
(define (next s)
  (if (>= s LANDING-COORDINATE) s (+ s 3)))

;State->Image
;Place the UFO at the given height into SCENE's center
(define (render y)
  (place-image (status-image y) (/ HEIGHT 4) (/ WIDTH 4) (place-image UFO SCENE-UFO-CENTER y SCENE))
  ) 

;Number->Image
;Returns a text image with the status of the ufo's landing
(define (status-image y)
  (cond
    [(<= y CLOSE)(text "DESCENDING" 20 "blue")]
    [(<= y LANDING-COORDINATE)(text "CLOSING IN" 20 "navy")]
    [else (text "LANDED" 20 "green")]
))

(main 0)
