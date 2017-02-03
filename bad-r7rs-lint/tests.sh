#!/usr/bin/env bash

sources=~/git/ChickenAndShout/hexdump/hexdump.scm

echo '=================================================='
echo '*                 GOSH                            '
echo '=================================================='
gosh -r 7 -I . ./gosh-bad-lint-r7rs.scm ${sources}

echo '=================================================='
echo '*                 GUILE                           '
echo '=================================================='
guile -s bad-lint-r7rs.scm ${sources}

echo '=================================================='
echo '*                 SAGITTARIUS                     '
echo '=================================================='
sagittarius bad-lint-r7rs.scm ${sources}

echo '=================================================='
echo '*                 CHICKEN                         '
echo '=================================================='
csi -b  -R r7rs -s bad-lint-r7rs.scm ${sources}

