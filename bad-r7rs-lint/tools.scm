;; ======================================================================
;; tools.scm
;; ======================================================================

(module tools racket
  (provide tprintln file-loader on-error)

  (define file-loader
    (lambda(file-name)
      (with-input-from-file file-name
        (lambda()
          (letrec ((rloop (lambda(acc)
                            (let ((expression (read)))
                              (if (eof-object? expression)
                                  (reverse acc)
                                  (rloop (cons expression acc)))))))
            (rloop '()))))))
  

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