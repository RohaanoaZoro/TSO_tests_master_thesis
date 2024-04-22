#!/bin/sh
GCC=gcc
GCCOPTS="-Wall -std=gnu99 -O2 -pthread"
LINKOPTS=""
/bin/rm -f *.exe *.s
$GCC $GCCOPTS -O2 -c outs.c
$GCC $GCCOPTS -O2 -c utils.c
$GCC $GCCOPTS -O2 -c litmus_rand.c
$GCC $GCCOPTS -O2 -c enable_tso.c
$GCC $GCCOPTS $LINKOPTS -o MP+DSB3.exe outs.o utils.o litmus_rand.o enable_tso.o MP+DSB3.c
$GCC $GCCOPTS -S MP+DSB3.c && awk -f show.awk MP+DSB3.s > MP+DSB3.t && /bin/rm MP+DSB3.s
