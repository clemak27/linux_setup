# Agent Rules

## Basic Rules

General rules for working in this environment.

### Environment

- You run on **Fedora**; many projects manage tools and tasks with **`mise`**
  (`mise run <task>`). Prefer `mise` tasks over raw commands when available.
- Restricted sandbox: only the current working directory + explicitly selected
  directories are accessible. Do not assume access to other paths.
- If you encounter sandbox or permission issues, don't try any workarounds, but
  inform the user.
- **Containers can't be started** in the sandbox: `docker` is emulated by
  `podman`, which fails with `Error determining cgroups mode`. If a task needs
  a container (e.g. a database), ask the user to start it instead of trying
  yourself.

### Research

- Prefer **web-search** to verify facts, versions, and APIs. Do not guess when
  a search can resolve the uncertainty.

### Git

- Always work on a **branch other than `main`** unless explicitly asked to work
  on main.
- Use **conventional commits** for commit messages (e.g. `feat:`, `fix:`,
  `chore:`).
- Never **push** to a remote, and never try any workaround to push. This
  includes `git push`, `git remote add`, force-pushing, and pushing to forks or
  branches. Do all local work on a branch and leave it here for review; only the
  user pushes.
- Commit locally so work is saved and reviewable, but leave branches locally —
  do not attempt to sync, share, or upload them anywhere.
- You may **amend commits** during review. When you do, the commit's
  **author and hash will change** — that's expected; don't be alarmed by a
  different hash.

### Pre-commit hooks

- Pre-commit hooks run automatically via **`hk`** if the repo contains a
  `hk.pkl` or `hk.local.pkl`. Do not bypass them.

## Language Rules

### java

- All my projects use `gradle`, not `mvn`.
- All my projects use Java 25.
- Use modern Java features wherever possible.

### markdown

- Always run `rumdl fmt` on any `.md` file you **create or edit**, before
  finishing the task — proactively, not only when asked.
- Re-run it again after every further edit to that file, so the result is
  always current.
- Format in place: `rumdl fmt <file>` (or `rumdl fmt <dir>/` for every `.md`
  file in a directory).

### yaml

- Always format YAML files with `yamlfmt` before finishing a task that creates
  or edits `*.yaml` / `*.yml`.
- Format in place: `yamlfmt <file>` (or `yamlfmt <dir>/` for every YAML file in
  a directory).
- After formatting, lint the file/files with `yamllint <file>`.
- Add a `# yamllint disable rule:line-length` comment in case of line-length
  issues.
