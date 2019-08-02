#!/usr/bin/env bash
set -euo pipefail

if [[ ! "${1:-}" || ! "${2:-}" ]]; then
    cat <<-EOF
Usage: $0 ENCRYPTION_KEY ENCRYPTED_FILE
EOF
    exit 1
fi

openssl enc -aes-256-cbc -d -k "$1" -in "$2"
