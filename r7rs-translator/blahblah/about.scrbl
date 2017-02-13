#lang scribble/manual
@(require (for-label racket))

@title{translating r7rs to another Scheme}

@italic{We can find a lot of Scheme compilers/interpreters on the Web. Each
of them have some weakness and some strongness. By translating @italic{r7rs} to
a known Scheme dialect, we can use the maximum of this dialect.}

@section{phase 1}
I start this work with @italic{drracket} because of the ease of debug this Scheme
system provides.

@subsection{writing @italic{racket} code}

The first lines must be a module definition with exported symbols and imported
modules. For example, the @italic{tools.rkt} module begins like this :

@racketblock[
(module tools racket
  (provide tprintln file-loader on-error)
  ...
  )
]

Another exemple :

@racketblock[
(module r7rs2rkt racket
  (provide on-file)
  (require racket/match "config.scm" "tools.rkt")
  ...
  )
]
