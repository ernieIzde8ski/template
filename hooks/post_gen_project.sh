#!/bin/sh

set -e

say() {
    printf '\033[0;34m' # blue
    echo -n ">>>" "$@"
    printf '\033[0m\n' # reset
}

say "Removing empty files..."
fd --size -0b --exclude='requirements.txt' --exclude 'py.typed' -X rm
say "Done!"

if [ -f .editorconfig ] \
    && fd --has-results Makefile \
    && ! rg --quiet 'Makefile' .editorconfig; then
    say "Adding Makefile to `.editorconfig`."
    echo -e '\n[Makefile]\nindent_style = tab' >> .editorconfig
fi

echo "Checking git state."
if ! git rev-parse 1>/dev/null 2>/dev/null; then
    say "No git repository present."
    say "Creating git repository."
    git init
else
    say "Repository is already a git repository (or git is not installed)."
    say "Removing prek configuration..."
    rm .pre-commit-config.yaml
fi

ensure_prek() {
    if command -v prek >/dev/null; then
        return 0
    elif command -v pipx >/dev/null; then
        say "Installing pre-commit."
        pipx install pre-commit
        return $?
    else
        say 'prek was not found and could not be automatically installed.' >&2
        say 'Please install prek or pipx manually.' >&2
        return 1
    fi
}

if [ -f .pre-commit-config.yaml ]; then
    ensure_prek
    prek autoupdate
    prek install
    git add . && prek run || :
fi

say "Done!"
