# DABT File Explorer

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
