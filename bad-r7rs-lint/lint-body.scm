;; ======================================================================
;; lint-body.scm
;; ======================================================================
(module lint-body racket
  (provide (all-defined-out))
  (require "tools.rkt")
  (require racket/match)

  (define current-compiler 'racket)

  (define on-library
    (lambda(library-name rest)
      (tprintln "Library: " library-name "\n")
      (lint-r7rs rest)))

  (define on-export
    (lambda(exported-symbols rest)
      (tprintln "Exported symbols : " exported-symbols "\n")
      (lint-r7rs rest)))

  (define on-import
    (lambda(imported-libs rest)
      (tprintln "Imported libs :\n")
      (for-each (lambda(s) (tprintln "   " s "\n")) imported-libs)
      (lint-r7rs rest)))

  (define on-define
    (lambda(body rest)
      (tprintln "  define : " (car body) "\n")
      ;; only for deep investgations
      ;; (lint-r7rs (cdr body))
      (lint-r7rs rest)))

  (define on-define-syntax
    (lambda(body rest)
      (tprintln "  define-syntax : " (car body) "\n")
      ;; only for deep investgations
      ;; (lint-r7rs (cdr body))
      (lint-r7rs rest)))

  (define on-cond-expand
    (lambda (conditionnals rest)
      (letrec ((loop (lambda(c)
                       (match c
                         ('()
                          (lint-r7rs rest))
                         ((list (list 'else more ...))
                          (lint-r7rs more)
                          (lint-r7rs rest))
                         ((list (list compiler-name more ...) others ...)
                          (cond
                            ((eq? compiler-name current-compiler)
                             (lint-r7rs more)
                             (lint-r7rs rest))
                            (else 
                             (loop others))))
                         (else 
                          (loop (cdr c)))))))
        (loop conditionnals))
      ))

  (define lint-r7rs
    (lambda(code)
      (cond
        ((null? code) #t)
        ((pair? code)
       
         (match code
           ((list 'define-library (list library-name ...) rest ...) (on-library library-name rest))
           ((list (list 'export symbols ...) rest ...) (on-export symbols rest))
           ((list (list 'import symbols ...) rest ...) (on-import symbols rest))
           ((list (list 'define body ...) rest ...) (on-define body rest))
           ((list (list 'define-syntax body ...) rest ...) (on-define-syntax body rest))
           ((list (list 'cond-expand conditionnals ...) rest ...) (on-cond-expand conditionnals rest))
           ((list head) (lint-r7rs head))
           ((list head rest ...) (lint-r7rs head) (lint-r7rs rest))))
        (else #t))))


  (define dohelp
    (lambda(exe-name exit-code)
      (tprintln exe-name " [-h|--help] : this text\n")
      (tprintln exe-name " file [file ...] : lint all the files\n")
      (exit exit-code)))

  (define on-file
    (lambda (file-name)
      (let ((doit (lambda()
                    (let ((p (file-loader file-name)))
                      (for-each lint-r7rs p)))))
        (tprintln "----------------------------------------------------------------------\n")
        (tprintln file-name "\n\n")
        (doit)
        )))

  (define themain
    (lambda (args)
      (tprintln "running themain for ")
      (tprintln "Compiler " current-compiler " Args " args "\n")
      (when (null? args)
        (dohelp "bad-lint" 0))
      (let ((exe-name (car args))
            (real_args (cdr args)))
        (tprintln "exe " exe-name " real_args " real_args "\n\n\n")

        (match real_args
          ('() (dohelp exe-name 0))
          ('("-h") (dohelp exe-name 0))
          ((list "-h" _ ...) (dohelp exe-name 0))
          ('("--help") (dohelp exe-name 0))
          ((list "--help" _ ...) (dohelp exe-name 0))
          (else 
           (for-each on-file real_args)
           (exit 0))))))


  (themain (list "racket-bad-lint-r7rs.scm" "/home/bernard/git/ChickenAndShout/hexdump/hexdump.scm"))
  #|
(if (not (eq? current-compiler 'mit))
    (begin
      (themain (command-line)))
    (tprintln "With Mit Scheme\n"))
|#
  )