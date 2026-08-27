;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname xml-reader) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/batch-io)
(require 2htdp/image)

;an Xexpr.v3 is one of:
;-- Symbol
;-- String
;-- Number
;-- (cons Symbol (cons Attribute*.v3 [List-of Xexpr.v3]))
;-- (cons Symbol [List-of Xexpr.v3])

;an Attribute*.v3 is a [List-of Attribute.v3]
;
;an Attribute.v3 is a list of two items:
;  (list Symbol String)


