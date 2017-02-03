;; ======================================================================
;; gosh-bad-r7rs.scm
;; bad-r7rs.scm for gosh
;;		gosh -r 7 -I . ./gosh-bad-r7rs.scm 
;; ======================================================================

(define-library
  (gosh-bad-r7rs)
  (import (scheme base) (scheme write) (scheme read) (scheme file) (scheme process-context) (util match))
  (begin
	;; (define current-compiler 'gosh)
	(include "./bad-r7rs.scm")))
