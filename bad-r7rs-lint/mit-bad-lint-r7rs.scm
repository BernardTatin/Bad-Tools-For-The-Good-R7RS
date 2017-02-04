;; ======================================================================
;; mit-bad-r7rs.scm
;; bad-r7rs.scm for mit-scheme
;;		gosh -r 7 -I . ./gosh-bad-r7rs.scm 
;; ======================================================================

(display "Starting..\n")
(define current-compiler 'mit)
(define include load)
(include "lint-body.scm")
