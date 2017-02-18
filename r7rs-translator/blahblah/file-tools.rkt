#lang scribble/lp
@(require(for-label))

@section{file tools}

@subsection{loading a program}
It's quite easy, we can do a quick and dirty function (the one I had before this) :

@chunk[<too-basic-file-loader>
       (define file-loader
         (lambda(file-name)
           (with-input-from-file file-name
             (lambda()
               (letrec ((rloop (lambda(acc)
                                 (let ((expression (read)))
                                   (if (eof-object? expression)
                                       acc
                                       (rloop (cons expression acc)))))))
                 (reverse (rloop '())))))))]


Because we do strange things on programs, we can do these things immediatly :


@chunk[<program-loader>
       (define program-loader
         (lambda(file-name compiler)
           (let ((the-loader
                  (lambda(compiler
                          (with-input-from-file file-name
                            (lambda()
                              (letrec ((rloop (lambda(acc)
                                                (let ((expression (read)))
                                                  (if (eof-object? expression)
                                                      acc
                                                      (rloop (cons (compiler expression) acc)))))))
                                (reverse (rloop '())))))))))
             (if (not compiler)
                 (the-loader (lambda(a) a))
                 (the-loader compiler)))))]
