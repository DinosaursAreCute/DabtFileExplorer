#!/usr/bin/env bash
# explorer.sh - entry script of the DABT File Explorer.
#   dabt app run explorer [START_DIR]        (or:  bash explorer.sh [START_DIR]  with DABT installed)
APP_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

# `dabt app run` exports TUI_ROOT; when started by hand, find DABT through the dabt command
if [[ -z "${TUI_ROOT:-}" ]] && command -v dabt >/dev/null 2>&1; then
    _dabt="$(readlink -f "$(command -v dabt)")"; TUI_ROOT="$(cd -P "$(dirname "$_dabt")/.." && pwd -P)"
fi
[[ -r "${TUI_ROOT:-}/lib/tui.sh" ]] || { echo "explorer: DABT not found. Install it first: https://github.com/DinosaursAreCute/DinosAmazingBashTui" >&2; exit 1; }

TUI_APP_NAME="${TUI_APP_NAME:-explorer}"
TUI_APP_TITLE="DABT File Explorer"; TUI_APP_DESC="Browse folders and preview file contents"; TUI_APP_ENTRY="explorer.sh"
source "$TUI_ROOT/lib/tui.sh"

FX_START="${1:-${DABT_CALL_DIR:-$PWD}}"      # dabt app run cds into the app: DABT_CALL_DIR is where you started it
[[ -d "$FX_START" ]] || { echo "explorer: '$FX_START' is not a folder" >&2; exit 1; }
FX_START="$(cd -P "$FX_START" && pwd -P)"

tui.start "$APP_DIR/config/explorer.xml"
