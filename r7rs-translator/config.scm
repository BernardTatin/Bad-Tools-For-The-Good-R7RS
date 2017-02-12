;; ======================================================================
;; config.scm
;; ======================================================================

(module config racket
  (provide exe-name in-debug)
  (define exe-name 'r7rs2rkt)
  (define in-debug #t))