;; ======================================================================
;; universal-inc.scm
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

(define on-library
  (lambda(library-name rest)
	(println "Library: " library-name "\n")
	(lint-r7rs rest)))

(define on-export
  (lambda(exported-symbols rest)
	(println "Exported symbols : " exported-symbols "\n")
	(lint-r7rs rest)))

(define on-import
  (lambda(imported-libs rest)
	(println "Imported libs :\n")
	(for-each (lambda(s) (println "   " s "\n")) imported-libs)
	(lint-r7rs rest)))

(define on-define
  (lambda(body rest)
	(println "  define : " (car body) "\n")
	(lint-r7rs (cdr body))
	(lint-r7rs rest)))

(define on-define-syntax
  (lambda(body rest)
	(println "  define-syntax : " (car body) "\n")
	(lint-r7rs (cdr body))
	(lint-r7rs rest)))

(define lint-r7rs
  (lambda(code)
	(cond
	  ((null? code) #t)
	  ((pair? code)
	   (match code
			  (('define-library (library-name ...) rest ...) (on-library library-name rest))
			  ((('export symbols ...) rest ...) (on-export symbols rest))
			  ((('import symbols ...) rest ...) (on-import symbols rest))
			  ((('define body ...) rest ...) (on-define body rest))
			  ((('define-syntax body ...) rest ...) (on-define-syntax body rest))
			  ((('cond-expand conditionnals ...) rest ...)
			   (letrec ((loop (lambda(c)
								(match c
									   ('()
										(lint-r7rs rest))
									   #|
									   ((('chicken more ...) others ...)
										(cond-expand
										  (chicken 
											(lint-r7rs more)
											(lint-r7rs rest))
										  (else (loop others))
										  ))
									   ((('guile more ...) others ...)
										(cond-expand
										  (guile 
											(lint-r7rs more)
											(lint-r7rs rest))
										  (else (loop others))
										  ))
									   ((('sagittarius more ...) others ...)
										(cond-expand
										  (sagittarius 
											(lint-r7rs more)
											(lint-r7rs rest))
										  (else (loop others))
										  ))
									   |#
									   ((('else more ...))
										(println "------- 'else \n")
										(lint-r7rs more)
										(lint-r7rs rest))
									   (((compiler-name more ...) others ...)
										(println "------- 1 compiler " compiler-name " current compiler "  current-compiler "\n")
										(cond
										  ((eq? compiler-name current-compiler)
										   (println "------- 2 compiler " compiler-name " found\n")
										   (lint-r7rs more)
										   (lint-r7rs rest))
										  (else 
										   (println "------- 3 compiler " compiler-name " NOT found\n")
											(loop others))))
									   (else 
										(println "------- compiler NO match \n")
										 (loop (cdr c)))))))
				 (loop conditionnals)))
			  ((head)
			   (lint-r7rs head))
			  ((head rest ...)
			   (lint-r7rs head)
			   (lint-r7rs rest))))
	  (else #t))))


(define dohelp
  (lambda(exe-name exit-code)
	(println exe-name " [-h|--help] : this text\n")
	(println exe-name " file [file ...] : lint all the files\n")
	(exit exit-code)))

(define on-file
  (lambda (file-name)
	(println "----------------------------------------------------------------------\n")
	(println file-name "\n\n")
	(let ((p (read-file file-name)))
	  (for-each lint-r7rs p))))

(define themain
  (lambda (args)
	(let ((exe-name (car args))
		  (_args (cdr args)))
	  (match _args
			 (() (dohelp exe-name 0))
			 (("-h") (dohelp exe-name 0))
			 (("-h" _ ...) (dohelp exe-name 0))
			 (("--help") (dohelp exe-name 0))
			 (("--help" _ ...) (dohelp exe-name 0))
			 (else 
			   (for-each on-file _args)
			   (exit 0))))))

(themain (command-line))
