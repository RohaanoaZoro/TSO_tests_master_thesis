#!/bin/sh
GCC=gcc
GCCOPTS="-Wall -std=gnu99 -fomit-frame-pointer -O2 -pthread"
LINKOPTS=""
/bin/rm -f *.exe *.s
$GCC $GCCOPTS -O2 -c outs.c
$GCC $GCCOPTS -O2 -c utils.c
$GCC $GCCOPTS -O2 -c litmus_rand.c
$GCC $GCCOPTS $LINKOPTS -o MP-x86.exe outs.o utils.o litmus_rand.o MP-x86.c
$GCC $GCCOPTS -S MP-x86.c && awk -f show.awk MP-x86.s > MP-x86.t && /bin/rm MP-x86.s
