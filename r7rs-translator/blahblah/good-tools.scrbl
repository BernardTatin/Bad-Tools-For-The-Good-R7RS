#lang scribble/lp2
@(require scribble/manual)
@(require (for-label racket))

@title{how to make the good tools}
@author{bernard tatin}

@para[#:style "abstract"]{It's more an experimentation of literate programming than a real @emph{Howto}.
The generated code will replace the previous @tt{tools} module.}@margin-note{humph...}

@section{the final module}

Just add a few line around all that stuff :

@chunk[<module>
       (module good-tools racket
         (provide print-all print-errors on-error)
         <printall>
         <printerrors>
         <onerror>
       )
       ]

@section{print utilities}

The first one is a simple @tt{print-all}, previously called @tt{tprintln}, which send all
of it's arguments to @tt{stdout} :

@chunk[<printall>
       (define print-all
         (lambda args
           (for-each display args)))]

The second on sends all it's arguments on @tt{stderr} and adds an end of line :

@chunk[<printerrors>
       (define print-errors
         (lambda args
           (for-each (lambda(element)
                       (display element (current-error-port)))
                       args)
           (display "\n" (current-error-port))))]


@section{error handling utilities}

We have @tt{onerror} whose first argument is an exit code and the others
a set of message to send on @tt{stderr} :

@chunk[<onerror>
       (define on-error
         (lambda args
           (let ((exit-code (car args))
                 (messages (cons "ERROR : " (cdr args))))
             (print-errors messages)
             (exit exit-code))))]

