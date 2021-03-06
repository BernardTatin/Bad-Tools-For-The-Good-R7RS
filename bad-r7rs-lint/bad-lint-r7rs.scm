#lang racket
;; ======================================================================
;; bad-r7rs.scm
;; Read r7rs sources files and interpret them
;; written with r5rs and some extensions
;; for guile 2.0.xx
;;  guile	: OK		(guile -s bad-r7rs.scm ../hexdump/hexdump.scm)
;;  sagittarius : OK		(sagittarius bad-r7rs.scm  ../hexdump/hexdump.scm)
;;  chicken	: OK		(csi -b  -R r7rs -s bad-r7rs.scm  ../hexdump/hexdump.scm)
;;  gosh        : OK		(gosh -r 7 -I . ./gosh-bad-r7rs.scm ../hexdump/hexdump.scm)

;;  kawa	: FAIL		(does not like else in match)
;;  mzscheme	: FAIL		(does not like define in cond-expand)
;;  foment	: FAIL		(foment bad-r7rs.scm syntax-violation variable "variable: bound to syntax" irritants: (...))
;;  gambit      : FAIL		(ggsi bad-r7rs.scm, Unbound variable: scheme)
;; ======================================================================

(cond-expand
  (guile 
	(define current-compiler 'guile)
	(use-modules (ice-9 match)))
  (foment
	(define current-compiler 'foment)
	(import (scheme base) (scheme write) (scheme read) (scheme file) (scheme process-context) 
			;; (bbmatch bbmatch)
			))
  (sagittarius
	(define current-compiler 'sagittarius)
	(import (scheme base) (scheme write) (scheme read) (scheme file) (scheme process-context) (match)))
  (chicken
	(define current-compiler 'chicken)
	(import (scheme base) (scheme write) (scheme read) (scheme file) (scheme process-context) (matchable) (extras)))
  (else
	(define current-compiler 'unknown)
	(import (scheme base) (scheme write) (scheme read) 
			(scheme process-context) 
			)))

(include "./lint-body.scm")
