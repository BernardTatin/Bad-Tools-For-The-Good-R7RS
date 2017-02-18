#lang scribble/manual
@(require(for-label racket))
@require[scribble/lp-include]

@title{how to make the good tools}
@author{bernard tatin}

@para[#:style "abstract"]{@bold{Abstract:} It's more an experimentation of literate programming than a real @elem[#:style "plain"]{Howto}.
This library gives some universal tools which can be used by a wide range of @elem[#:style "plain"]{Scheme} systems.
}

@lp-include["good-tools.rkt"]
@lp-include["file-tools.rkt"]