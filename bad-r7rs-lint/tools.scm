;; ======================================================================
;; tools.scm
;; ======================================================================

(module tools racket
  (provide tprintln file-loader)

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
  )