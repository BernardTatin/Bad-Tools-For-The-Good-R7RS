# _bad-r7rs.scm_, my first steps in compilation...

To use it, one of these line :

```bash
$ guile -s bad-r7rs.scm ../hexdump/hexdump.scm
$ sagittarius bad-r7rs.scm  ../hexdump/hexdump.scm
$ csi -b  -R r7rs -s bad-r7rs.scm  ../hexdump/hexdump.scm
$ gosh -r 7 -I . ./gosh-bad-r7rs.scm ../hexdump/hexdump.scm
```
On FreeBSD, we used :

 - `guile 2.0.11`,
 - `sagittarius 0.7.11`,
 - `csi (CHICKEN) 4.11.0`,
 - `gosh (GAUCHE) 0.9.4`.

For `foment`, `mit-scheme` or `gambit-scheme`, we need some work.

# well...

I want to write a program which can be executed by a lot of scheme compilers. But there is two big problems :

 - modules,
 - libraries like _match_.

It's really difficult to make a universal module system. And _match_ has not the same syntax every where.

For the moment, I'll work with _racket_ which makes debug easier.

# quick notes

## environment

I need to add an extra parameter, _environment_, to `lint-r7rs` function. It will contain :

 - current file name,
 - current scope (library, `define`, `let`, `lambda`...),
 - what else?

This _environment_ can be :

 - a structure unless one of the preceding scheme environment does not support it,
 - a list.
