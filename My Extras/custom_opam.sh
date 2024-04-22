#!/bin/sh

set -e

if test $# -lt 1 ; then
  echo "$0 requires at least 1 argument."
  exit 1
fi

arch=$1
shift

opam var --global "arch=$arch"
arch "-$arch" opam "$@"