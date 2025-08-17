#!/bin/sh

set -e

echo "Removing empty files..."
fd --size -0b --exclude='requirements.txt' --exclude 'py.typed' -X rm
echo ">>> Done!"
echo

echo "checking git state..."
if ! git rev-parse 1>/dev/null 2>/dev/null; then
    echo ">>> No git repository present."
    echo ">>> Creating git repository & installing pre-commit."
    git init
    command -v pre-commit || pipx install pre-commit
    pre-commit autoupdate
    pre-commit install
else
    echo ">>> Repository is already a git repository"
    echo "... (or git is not installed)."
    echo ">>> Removing pre-commit configuration..."
    rm .pre-commit-config.yaml
fi

echo ">>> Done!"
