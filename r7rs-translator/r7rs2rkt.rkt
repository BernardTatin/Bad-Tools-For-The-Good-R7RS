;; #lang racket
;; ======================================================================
;; r7rs2rkt.rkt
;; ======================================================================

(module r7rs2rkt racket
  (require "config.scm")
  (require "blahblah/good-tools.rkt")
  
  (define file-loader
    (lambda(file-name)
      (with-input-from-file file-name
        (lambda()
          (letrec ((rloop (lambda(acc)
                            (let ((expression (read)))
                              (if (eof-object? expression)
                                  acc
                                  (rloop (cons expression acc)))))))
            (reverse (rloop '())))))))
  


  (define to-racket
    (lambda(program)
      (match program
        ('() program)
        ((list 'define-library (list library-name) rest ...)
         (list 'module library-name 'racket (to-racket rest)))
        ((list (list 'export exported ...) rest ...)
         (let ((provided (cons 'provide exported)))
           (cons provided (to-racket rest))))
        (else
         program))))

  
  (define on-file
    (lambda(file-name)
      
      (define print-program
        (lambda (title program)
          (print-all title "\n")
          (for-each (lambda(p) (print-all p "\n")) program)
          (display "\n\n\n")))
      
      (if (file-exists? file-name)
          (let ((program (file-loader file-name)))
            (print-program ";; program:\n" program)
            (let ((translated-program (map to-racket program)))
              (print-program ";; translated program\n" translated-program)))
          (on-error 2 "File " file-name " can't be read\n"))))
  
  (define dohelp
    (lambda(exit-code)
      (print-all exe-name " [-h|--help] : this text\n")
      (print-all exe-name " -r|--run source : execute source file\n")
      (exit exit-code)))
  
  (define themain
    (lambda(args)
      (letrec ((mloop
                (lambda(_args empty-list-for-help)
                  (match _args
                    ('() (when empty-list-for-help (dohelp 0)))
                    ((or '("-h") '("--help")) (dohelp 0))
                    ((or (list "-h" _ ...) (list "--help" _ ...)) (dohelp 0))
                    ((or (list "-r" source rest ...) (list "--run" source rest ...)) (on-file source) (mloop rest #f))
                    (else (on-error 1 "Unkown parameter " _args "\n"))))))
        (mloop args #t))))

  (if in-debug
      (themain (list "-r" "/home/bernard/git/ChickenAndShout/hexdump/hexdump.scm"))
      (themain (vector->list (current-command-line-arguments))))
  )
