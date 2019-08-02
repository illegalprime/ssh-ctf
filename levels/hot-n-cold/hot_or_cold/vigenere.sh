#!/usr/bin/env bash
set -euo pipefail

key="$1"
plaintext="$2"

for (( i=0; i < ${#plaintext}; i++ )); do
    offset="${key:$((i % ${#key})):1}"
    char="${plaintext:$i:1}"
    echo $(( $(printf '%d\n' "'$offset") ^ $(printf '%d\n' "'$char") ))
done
