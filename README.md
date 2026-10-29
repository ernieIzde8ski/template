# Template - Project

A cookiecutter template for generic projects.

## Requirements

- any POSIX-compliant shell
- `python3` (with `PyYAML`)
- `cookiecutter`
- `git`
- `fd`
- `pre-commit` (will auto-install if pipx is available)

Example setup for Void Linux:

```sh
xi python3 python3-yaml git fd python3-pipx
pipx install cookiecutter
```

## Usage

```sh
cookiecutter gh:ernieIzde8ski/template [-c <branch>]
```

Cookiecutter documentation: <https://cookiecutter.readthedocs.io/en/2.0.2/README.html>
