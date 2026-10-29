#!/bin/sh

set -e

echo "Removing empty files..."
fd --size -0b --exclude='requirements.txt' --exclude 'py.typed' -X rm
echo ">>> Done!"
echo

echo "checking git state..."
if ! git rev-parse 1>/dev/null 2>/dev/null; then
    echo ">>> No git repository present."
    echo ">>> Creating git repository."
    git init
else
    echo ">>> Repository is already a git repository (or git is not installed)."
    echo ">>> Removing prek configuration..."
    rm .pre-commit-config.yaml
fi

ensure_prek() {
    if command -v prek >/dev/null; then
        return 0
    elif command -v pipx >/dev/null; then
        pipx install pre-commit
        return $?
    else
        echo '`prek` was not found and could not be automatically installed.' >&2
        return 1
    fi
}

if [ -f .pre-commit-config.yaml ]; then
    ensure_prek
    prek autoupdate
    prek install
fi

echo ">>> Done!"
