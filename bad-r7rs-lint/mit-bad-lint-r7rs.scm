;; ======================================================================
;; mit-bad-r7rs.scm
;; bad-r7rs.scm for mit-scheme
;;		gosh -r 7 -I . ./gosh-bad-r7rs.scm 
;; ======================================================================

(define-syntax when
  (syntax-rules ()
    ((_ pred b1 ...)
     (if pred (begin b1 ...)))))

(display "Starting..\n")
(define current-compiler 'mit)
(define include load)
(include "lint-body.scm")
(themain '("mit-scheme" "~/git/ChickenAndShout/hexdump/hexdump.scm"))
