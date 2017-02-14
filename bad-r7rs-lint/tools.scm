;; ======================================================================
;; tools.scm
;; ======================================================================

(module tools racket
  (provide tprintln file-loader on-error)


  (define tprintln
    (lambda args
      (for-each display args)))

  (define on-error
    (lambda args
      (let ((exit-code (car args))
            (_args (cdr args)))        
        (for-each (lambda(e) (display e (current-error-port))) _args)
        (exit exit-code))))
  
  )