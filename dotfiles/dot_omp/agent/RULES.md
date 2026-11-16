# Agent Rules

General rules for working in this environment.

## Environment

- You run on **Fedora**; many projects manage tools and tasks with **`mise`**
  (`mise run <task>`). Prefer `mise` tasks over raw commands when available.
- Restricted sandbox: only the current working directory + explicitly selected
  directories are accessible. Do not assume access to other paths.
- If you encounter sandbox or permission issues, don't try any workarounds, but
  inform the user.

## Research

- Prefer **web-search** to verify facts, versions, and APIs. Do not guess when
  a search can resolve the uncertainty.

## Markdown

Always format `.md` files with `rumdl fmt`.

## Git

- Always work on a **branch other than `main`** unless explicitly asked to work
  on main.
- Use **conventional commits** for commit messages (e.g. `feat:`, `fix:`,
  `chore:`).

## Pre-commit hooks

- Pre-commit hooks run automatically via **`hk`** if the repo contains a
  `hk.pkl` or `hk.local.pkl`. Do not bypass them.
