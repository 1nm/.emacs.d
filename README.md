# My Emacs Configuration

Emacs 31, no external framework. Everything the built-ins cover well is left to
the built-ins; packages are only added where they do something Emacs does not.

## Usage

Clone this repo to `~/.emacs.d` and start `emacs`. Missing packages are
installed from MELPA on first start. Then run `M-x my/install-treesit-grammars`
once to compile the tree-sitter grammars (needs `git` and a C compiler).

## Files

- `early-init.el` — runs before package.el and the first frame: GC tuning,
  `package-quickstart`, frame/UI settings.
- `init.el` — settings and packages, declared with the built-in `use-package`.
- `custom.el` — variables and faces saved by `M-x customize`.

## Key bindings

### Completion and search

Completion is the built-in `fido-vertical-mode`: candidates listed under the
prompt, `RET` takes the highlighted one. Inside the minibuffer it uses the
`flex` style, so `dfci` finds `display-fill-column-indicator-mode`. With
`completions-detailed`, `M-x` also shows each command's key binding and the
first line of its doc string.

| Key | Command |
| --- | --- |
| `M-x` | commands, with `flex` matching |
| `C-x C-f` | find file |
| `C-x b` | switch buffer |
| `C-x C-r` | `recentf-open` — recently visited files |
| `C-s` / `C-M-s` | isearch / regexp isearch (`isearch-lazy-count` shows `3/17`) |
| `M-s o` | `occur` — every matching line in its own buffer |
| `M-s .` | search for the symbol at point |
| `C-c C-i` | `imenu` |
| `M-x rgrep` | recursive grep over a directory |
| `C-x p f` / `p g` / `p b` / `p p` | project: find file / search / buffer / switch |

### Git

The built-in `vc`; `C-x v` is its prefix.

| Key | Command |
| --- | --- |
| `C-x g` (or `C-x v d`) | `vc-dir` — status for the tree |
| `C-x v =` | diff |
| `C-x v l` | log |
| `C-x v v` | the next logical action (stage/commit) |
| `C-x v g` | annotate (blame) |
| `C-x C-g` | `vc-git-grep` |
| `z` (in a vc-dir buffer) | stash: create, apply, pop, delete, show, snapshot |

Changed lines are marked in the fringe by `diff-hl`, live, without saving.

### Editing and navigation

| Key | Command |
| --- | --- |
| `C-x C-M-d` | `duplicate-dwim` — copy the line or region |
| `M-/` | `hippie-expand` |
| `M-n` / `M-p` | scroll one line down / up |
| `C-c C-r` | `query-replace-regexp` |
| `M-s h .` | highlight every occurrence of the symbol at point (`M-s h u` clears) |
| `C-c l r/a/f/d` | eglot rename / code actions / format / docs |
| `C-c ! l/n/p` | flymake: list / next / previous diagnostic |

### Windows, tabs and buffers

| Key | Command |
| --- | --- |
| `C-x C-b` | `ibuffer` |
| `C-x t 2` / `C-x t 0` / `C-x t o` | new / close / next tab (a tab is a whole window layout) |
| `C-x 4 4` + any command | show that command's result in another window (`C-x 5 5` frame, `C-x t t` tab) |
| `C-x C-q` (in dired) | wdired — edit filenames as text, `C-c C-c` to apply |
| `C-x C-j` | `dired-jump` — dired for the current buffer's directory |

`repeat-mode` is on, so after a prefix you can keep pressing the last key:
`C-x o o o` cycles windows, `C-x { { }` resizes, `M-g n n n` walks errors,
`C-x [ ] ]` pages, `C-x u u u` undoes.

### Notes

Markdown notes live in `~/Library/Mobile Documents/com~apple~CloudDocs/Notes/`
(iCloud Drive). Emacs starts in `*scratch*`; reach for notes explicitly.

| Key | Command |
| --- | --- |
| `C-c n n` | new date-prefixed note (choose a category, enter a title) |
| `C-c n l` | open the latest note |
| `C-c n i` | open `inbox.md` for quick capture |
| `C-c n s` | grep the notes directory |
| `C-c p` | render with pandoc into an eww window on the right |

### Markdown

`markdown-ts-mode` is built into Emacs 31 and replaces the markdown-mode
package. Its table editor also replaces the old orgtbl workaround — tables are
edited natively, so nothing rewrites separators on save any more.

| Key | Command |
| --- | --- |
| `TAB` | cycle the heading's visibility |
| `M-←` / `M-→` | promote / demote heading |
| `M-↑` / `M-↓` | move the subtree up / down |
| `C-c C-c` | toggle the checkbox at point |
| `RET` / `M-RET` | continue the list / new list item |
| `C-c C-x C-m` | hide markup (`**`, `[]()`, ...) |
| `C-c C-x C-v` | show inline images |
| `C-c C-x C-r` | renumber the list |

Inside a table, cells auto-align as you navigate them. `M-x markdown-ts-table-`
also gives insert/delete/move row and column, transpose, align, and CSV/TSV
import and export.

## Language support

JSON, YAML, Python, shell, TOML and Markdown use the built-in tree-sitter
modes, so no json-mode/yaml-mode/python-mode/markdown-mode packages are
needed. A mode is only remapped once its grammar is compiled, so a fresh clone
still opens these files.

`eglot` is the built-in LSP client. It is not auto-started — run `M-x eglot`
in a project once a language server is installed (`pyright`, `gopls`, ...).
Inline completion suggestions come from the built-in `completion-preview-mode`
(`C-M-n` / `C-M-p` to cycle).

## Optional external tools

The config degrades gracefully without these, but they unlock features:

- `pandoc` — markdown preview (`C-c p`); the command says so if it is missing
- `ripgrep` — `M-s r` and `C-c n s`
- `hunspell` or `aspell` — spell checking (`M-$`)

## Start Emacs in client mode

`server-start` runs from `emacs-startup-hook`. Add to `.zshrc`:

```sh
export EDITOR="`which emacsclient` -c -nw"
export VISUAL="`which emacsclient` -c"
export ALTERNATE_EDITOR=""
alias emacs=$EDITOR
alias emacsg=$VISUAL
```

## Packages

Three, installed automatically from MELPA on first start:

- [diff-hl](https://github.com/dgutov/diff-hl) — VC diffs in the fringe
- [nyan-mode](https://github.com/TeMPOraL/nyan-mode) — the cat
- [rainbow-delimiters](https://github.com/Fanael/rainbow-delimiters) — parens coloured by nesting depth

Everything else is built in: `fido-vertical-mode` for completion, `vc` for git,
tree-sitter modes for every language, `eglot` for LSP, `completion-preview-mode`
for in-buffer completion, `which-key`, `savehist`, `save-place`, `repeat-mode`,
`ibuffer`, `hippie-expand`, `duplicate-dwim`, `tab-bar`, `flymake`.
