#!/usr/bin/env bash
set -euo pipefail

# TODO: more questions!
mapfile -t questions <<-EOF
Oooo, I am the riddler, are you ready for my riddles?|Yes,No,...
OK, let's start with an easy one,
Good job,
EOF

responses=""
for question in "${questions[@]}"; do
    # show question
    cut -d'|' -f1 <<< "$question"
    # get a list of answers
    IFS=',' read -r -a answers < <(
        cut -d'|' -f2 <<< "$question"
    )
    # get the answer!
    select opt in "${answers[@]}"; do
        responses="${responses}-${opt}"
        break
    done
done

echo 'Your answers generated this key, it might decrypt the flag!'
sha256sum <<< "$responses" | cut -d' ' -f1
