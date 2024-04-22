#!/bin/sh
GCC=gcc
GCCOPTS="-Wall -std=gnu99 -O2 -pthread"
LINKOPTS=""
/bin/rm -f *.exe *.s
$GCC $GCCOPTS -O2 -c outs.c
$GCC $GCCOPTS -O2 -c utils.c
$GCC $GCCOPTS -O2 -c litmus_rand.c
$GCC $GCCOPTS -O2 -c enable_tso.c
$GCC $GCCOPTS $LINKOPTS -o MPx.exe outs.o utils.o litmus_rand.o enable_tso.o MPx.c
$GCC $GCCOPTS -S MPx.c && awk -f show.awk MPx.s > MPx.t && /bin/rm MPx.s
