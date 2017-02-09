;; ======================================================================
;; tools.scm
;; ======================================================================

(module tools racket
  (provide tprintln file-loader on-error)

  (define file-loader
    (lambda(file-name)
      (tprintln "read file <" file-name ">\n")
      (with-input-from-file file-name
        (lambda()
          (letrec ((rloop (lambda(acc)
                            (let ((expression (read)))
                              (if (eof-object? expression)
                                  (reverse acc)
                                  (rloop (cons expression acc)))))))
            (rloop '()))))))
  

  (define (tprintln . args)
    (for-each display args))

  (define (on-error . args)
    (for-each (lambda(e) (display e (current-error-port))) (cdr args))
    (exit (car args)))
  
  )