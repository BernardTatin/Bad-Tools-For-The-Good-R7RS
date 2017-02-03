;; ======================================================================
;; tools.scm
;; ======================================================================

(define (println . args)
  (for-each display args))

(define read-file
  (lambda(file-name)
	(let ((handle (open-input-file file-name)))
	  (letrec ((rloop (lambda(acc)
						(let ((expression (read handle)))
						  (if (eof-object? expression)
							(reverse acc)
							(rloop (cons expression acc)))))))
		(let ((r (rloop '())))
		  (close-input-port handle)
		  r)))))

