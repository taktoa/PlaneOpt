#!/run/current-system/sw/bin/bash

[[ -n "$1" ]] && VARS="$1"
[[ -z "$1" ]] && VARS="vars.txt"

[[ -n "$2" ]] && SCR="$2"
[[ -z "$2" ]] && SCR="script.xfoil"

[[ -f $VARS ]] && source $VARS
[[ ! -f $VARS ]] && ( set -o posix ; set ) | egrep -v '(_|/|TERM|USER)' | grep -v "'" | egrep -v '(\(|\)|:)' > $VARS

TEMP1="$(mktemp tmp.runxfoil.XXXX)"
TEMP2="$(mktemp tmp.runxfoil.XXXX)"
cut -d '=' -f 1 $VARS > $TEMP1
paste -d ' ' $TEMP1 $TEMP1 | sed 's/ /\/$/g; s/^/sed \"s\/%/g; s/$/\/g\" | /g' | tr -d '\n' | sed 's/ | $//g' | sed "s/^/cat $SCR | /g" > $TEMP2
cat $VARS $TEMP2 $CMDS | bash | xfoil &> /dev/null
rm -f $TEMP1 $TEMP2

cat $OUT

rm -f :00.bl $OUT
