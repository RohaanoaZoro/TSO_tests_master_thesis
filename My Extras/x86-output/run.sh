#!/bin/sh

date
LITMUSOPTS="${@:-$LITMUSOPTS}"
SLEEP=0
if [ ! -f MP-x86.no ]; then
cat <<'EOF'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Results for MP-x86.litmus %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X86 MP
"PodWW Rfe PodRR Fre"

{
}
 P0         | P1          ;
 MOV [x],$1 | MOV EAX,[y] ;
 MOV [y],$1 | MOV EBX,[x] ;

exists (1:EAX=1 /\ 1:EBX=0)
Generated assembler
EOF
cat MP-x86.t
./MP-x86.exe -q $LITMUSOPTS
fi
sleep $SLEEP

cat <<'EOF'
Revision exported, version 7.56+03
Command line: litmus7 MP-x86.litmus -o ./x86-output/sb-litmus.tar
Parameters
#define SIZE_OF_TEST 10000000
#define NUMBER_OF_RUN 10
#define AVAIL 1
#define STRIDE (-1)
#define MAX_LOOP 0
/* gcc options: -Wall -std=gnu99 -fomit-frame-pointer -O2 -pthread */
/* barrier: user */
/* launch: changing */
/* affinity: none */
/* memory: direct */
/* safer: write */
/* preload: random */
/* speedcheck: no */
/* alloc: dynamic */
EOF
sed '2q;d' comp.sh
echo "LITMUSOPTS=$LITMUSOPTS"
date
