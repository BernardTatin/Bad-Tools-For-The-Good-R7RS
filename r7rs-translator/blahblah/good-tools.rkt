#lang scribble/lp
@(require(for-label))


@section{print utilities}

@subsection{not exported}
The first one is a simple @tt{inner-print-all}, whose first argument is a port
and the rest of the arguments is a set of objects to send on @tt{port}

@chunk[<innerprintall>
       (define inner-print-all
         (lambda args
           (let ((port (car args))
                 (messages (cdr args)))
             (for-each (lambda(m)
                         (display m port))
                       messages))))]


@subsection{exported}
The second one is a simple @tt{print-all}, previously called @tt{tprintln}, which send all
-of it's arguments to @tt{stdout}

@chunk[<printall>
       (define print-all
         (lambda args
           (inner-print-all (current-output-port) args)))]

The third sends all it's arguments on @tt{stderr} and adds an end of line :

@chunk[<printerrors>
       (define print-errors
         (lambda args
           (inner-print-all (current-error-port) args "\n")))]

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


@section{the final module}

Here is the result :

@chunk[<*>
       (require racket)
       (provide print-all print-errors on-error)
       <innerprintall>
        
       <printall>
       <printerrors>
         
       <onerror>]

@section{comming soon ...}

Testing is always the next great thing which is coming soon. Hmmmm....
The @italic{great} test I have done is simple: I used this module by @italic{requiring} it
in another program. All the cases where covered. Not reproductible easily. A @italic{great bad} test...

@section{conclusion}

It's my first try with @italic{Scribble}. The lack of documentation of this great tool make the beginning
hard. But now, I'm really glad of the result. I found a better way of coding.