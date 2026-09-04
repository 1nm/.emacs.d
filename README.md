# My Emacs Configuration

## Usage

Clone this repo to `~/.emacs.d` and start `emacs`. Missing packages are
installed from MELPA on first start.

## Files

- `early-init.el` — runs before package.el and the first frame: GC tuning,
  `package-quickstart`, frame/UI settings.
- `init.el` — settings and packages, declared with the built-in `use-package`
  and loaded lazily (on first key press / file open, or after 1s idle).
- `custom.el` — variables and faces saved by `M-x customize`.

## Notes

Markdown notes live in `~/Library/Mobile Documents/com~apple~CloudDocs/Notes/`
(iCloud Drive). Starting Emacs without a file, or opening a new `emacsclient -c`
frame, shows the most recently modified note.

- `C-c n n` — new date-prefixed note (choose a category, enter a title)
- `C-c n l` — open the latest note
- `C-c n i` — open `inbox.md` for quick capture
- `C-c p` — toggle live preview in an eww window on the right (markdown-mode)

## Start Emacs in Client Mode

Add the following to `.bashrc` if you are using bash, or `.zshrc` if you are using zsh

```
export EDITOR="`which emacsclient` -c -nw"
export VISUAL="`which emacsclient` -c"
export ALTERNATE_EDITOR=""
alias emacs=$EDITOR
alias emacsg=$VISUAL
```

## Packages

Installed automatically from MELPA on first start:

- [anzu](https://github.com/syohex/emacs-anzu)
- [helm](https://github.com/emacs-helm/helm)
- [json-mode](https://github.com/joshwnj/json-mode)
- [markdown-mode](https://github.com/jrblevin/markdown-mode)
- [nyan-mode](https://github.com/TeMPOraL/nyan-mode)
- [rainbow-delimiters](https://github.com/Fanael/rainbow-delimiters)
- [yaml-mode](https://github.com/yoshiki/yaml-mode)
