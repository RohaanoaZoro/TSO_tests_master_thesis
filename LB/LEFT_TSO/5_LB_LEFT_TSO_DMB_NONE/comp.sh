#!/bin/sh
GCC=gcc
GCCOPTS="-Wall -std=gnu99 -O2 -pthread"
LINKOPTS=""
/bin/rm -f *.exe *.s
$GCC $GCCOPTS -O2 -c outs.c
$GCC $GCCOPTS -O2 -c utils.c
$GCC $GCCOPTS -O2 -c litmus_rand.c
$GCC $GCCOPTS -O2 -c enable_tso.c
$GCC $GCCOPTS $LINKOPTS -o X.exe outs.o utils.o litmus_rand.o enable_tso.o X.c
$GCC $GCCOPTS -S X.c && awk -f show.awk X.s > X.t && /bin/rm X.s
