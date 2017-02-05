;; ======================================================================
;; tools.scm
;; ======================================================================

(define (println . args)
  (for-each display args))

(define read-file
  (lambda(file-name)
	(println "read file <" file-name ">\n")
	(with-input-from-file file-name
						  (lambda()
							(letrec ((rloop (lambda(acc)
											  (let ((expression (read)))
												(if (eof-object? expression)
												  (reverse acc)
												  (rloop (cons expression acc)))))))
							  (rloop '()))))))
