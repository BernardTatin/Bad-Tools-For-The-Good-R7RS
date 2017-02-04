#!/usr/bin/env bash

sources=~/git/ChickenAndShout/hexdump/hexdump.scm

domit () {
	echo '=================================================='
	echo '*                 MIT-SCHEME                     *'
	echo '=================================================='
	mit-scheme --quiet --eval "(load \"mit-bad-lint-r7rs.scm\") (themain '(mit-bad-lint-r7rs ${sources}))"
}

dofoment () {
	echo '=================================================='
	echo '*                 FOMENT                         *'
	echo '=================================================='
	foment -I . ./bad-lint-r7rs.scm ${sources}
}

dogosh () {
	echo '=================================================='
	echo '*                 GOSH                           *'
	echo '=================================================='
	gosh -r 7 -I . ./gosh-bad-lint-r7rs.scm ${sources}
}

doguile () {
	echo '=================================================='
	echo '*                 GUILE                          *'
	echo '=================================================='
	guile --fresh-auto-compile -s bad-lint-r7rs.scm ${sources}
}

dosagittarus () {
	echo '=================================================='
	echo '*                 SAGITTARIUS                    *'
	echo '=================================================='
	sagittarius bad-lint-r7rs.scm ${sources}
}

dochicken () {
	echo '=================================================='
	echo '*                 CHICKEN                        *'
	echo '=================================================='
	csi -b  -R r7rs -s bad-lint-r7rs.scm ${sources}
}

dohelp () {
	local script=$(basename $0)
	cat << DOHELP
==================================================
*                 HELP                           *
==================================================

${script} gosh|sagittarius|guile|chicken|all : 
${script} : same as ${script} all
DOHELP
	exit 0
}
option=all

[ $# -ne 0 ] && option=$1

case ${option} in
	gosh|sagittarius|guile|chicken|foment|mit)
		do${option}
		;;
	all)
		for c in gosh sagittarius guile chicken
		do
			do${c}
		done
		;;
	*)
		dohelp
		;;
esac
