#!/usr/bin/env bash
# explorer_callbacks.sh - DABT File Explorer handlers.
FX_DIR=""; FX_HIDDEN=0

fx_visit() { fx_cd "${FX_DIR:-$FX_START}"; }

# fx_cd DIR - list DIR into the table and mirror it in the address bar
fx_cd() {
    local d rows=() f kind size
    d="$(cd -P -- "$1" 2>/dev/null && pwd -P)" || { tui.notify "Not a folder: $1" error 3; tui.update fx_path "$FX_DIR"; return 1; }
    FX_DIR="$d"
    [[ "$d" != / ]] && rows+=("..||dir")
    shopt -s nullglob; (( FX_HIDDEN )) && shopt -s dotglob
    for f in "$d"/*; do
        [[ "${f##*/}" == . || "${f##*/}" == .. ]] && continue
        if [[ -d "$f" ]]; then kind=dir; size=""; else kind=file; size="$(stat -c %s -- "$f" 2>/dev/null)"; fi
        rows+=("${f##*/}|$size|$kind")
    done
    shopt -u dotglob nullglob
    tui.table.set fx_table "Name|Size|Kind" "${rows[@]}"
    tui.update fx_path "$d"
    tui.output fx_preview ""
}

fx_goto() { local p; p="$(tui.get fx_path)"; p="${p/#\~/$HOME}"; fx_cd "$p" && tui.pane.focus fx_files; }
fx_up() { fx_cd "$FX_DIR/.."; }
fx_home() { fx_cd "$HOME"; }
fx_reload() { fx_cd "$FX_DIR"; }
fx_toggle_hidden() { FX_HIDDEN=$((1 - FX_HIDDEN)); fx_cd "$FX_DIR"; }

fx_open() {
    local name; name="$(tui.table.row fx_table)"; name="${name%%|*}"
    [[ -d "$FX_DIR/$name" ]] && fx_cd "$FX_DIR/$name"
}

fx_moved() {
    local name f; name="$(tui.table.row fx_table)"; name="${name%%|*}"; f="$FX_DIR/$name"
    if [[ -d "$f" ]]; then tui.output fx_preview "$(ls -1 -- "$f" 2>/dev/null | head -50)"
    elif [[ -r "$f" ]]; then tui.output fx_preview "$(head -c 20000 -- "$f" | tr -d '\000')"
    fi
}

fx_view_full() { local n; n="$(tui.table.row fx_table)"; [[ -f "$FX_DIR/${n%%|*}" ]] && tui.output fx_preview "$(tr -d '\000' < "$FX_DIR/${n%%|*}")"; }
