;; ======================================================================
;; r7rs2rkt.rkt
;; ======================================================================

(module r7rs2rkt racket
  (provide (all-defined-out))
  (require "tools.rkt")
  (require racket/match)
  (define exe-name 'r7rs2rkt)

  (define on-file
    (lambda(file-name)
      (if (file-exists? file-name)
          (let ((program (file-loader file-name)))
            (tprintln "program:\n" program "\n"))
          (on-error 2 "File " file-name " can't be read\n"))))
  
  (define dohelp
    (lambda(exit-code)
      (tprintln exe-name " [-h|--help] : this text\n")
      (tprintln exe-name " -r|--run source : execute source file\n")
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

  (themain (vector->list (current-command-line-arguments)))
  )
