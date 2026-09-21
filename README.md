# DABT File Explorer

[![Build](https://github.com/DinosaursAreCute/DabtFileExplorer/actions/workflows/dabt-release.yml/badge.svg)](https://github.com/DinosaursAreCute/DabtFileExplorer/actions/workflows/dabt-release.yml)

A terminal file explorer written in pure bash. Browse folders and preview file contents with keyboard and mouse. Built on **[D.A.B.T (DinosAmazingBashTui)](https://github.com/DinosaursAreCute/DinosAmazingBashTui)**, the zero-dependency bash TUI framework ([docs](https://dinosaursarecute.github.io/DinosAmazingBashTui/)).

## Install

Requires [DABT](https://github.com/DinosaursAreCute/DinosAmazingBashTui) and bash 5+.

```bash
dabt app install https://github.com/DinosaursAreCute/DabtFileExplorer
dabt app run explorer [START_DIR]
```

Or run it directly with DABT installed: `bash explorer.sh [START_DIR]`.

## Layout

- `explorer.sh`: entry script
- `config/explorer.xml`: page markup
- `config/explorer_callbacks.sh`: event handlers
- `config/theme.css`: styling

Want to build your own app like this? See [Writing Your First App](https://dinosaursarecute.github.io/DinosAmazingBashTui/tutorials/writing-your-first-app).

## Build and release

Packaged with `dabt build` (see `dabt.pkg`); the `.dapk` is signed and installable with `dabt app install`.

```bash
dabt build                                   # -> dist/explorer-<version>+<build>.dapk
dabt pkg release minor                       # bump VERSION, close the changelog's Unreleased section, commit + tag
git push --follow-tags                       # the workflow in .github/workflows builds, signs and drafts the GitHub release
```

Add the private signing key as the repository secret `DABT_SIGN_KEY`. Release notes come from `CHANGELOG.md` (`### News` bullets are shown to users before they update).
