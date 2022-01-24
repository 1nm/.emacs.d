# My Emacs Configuration

## Usage

Clone this repo to `~/.emacs.d` and start `emacs`

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

- [anzu](https://github.com/syohex/emacs-anzu)
- [auto-complete](https://github.com/auto-complete/auto-complete)
- [exec-path-from-shell](https://github.com/purcell/exec-path-from-shell)
- [helm](https://github.com/emacs-helm/helm)
- [helm-ag](https://github.com/emacsorphanage/helm-ag)
- [highlight-symbol](https://github.com/nschum/highlight-symbol.el)
- [json-mode](https://github.com/joshwnj/json-mode)
- [magit](https://github.com/magit/magit)
- [markdown-mode](https://github.com/jrblevin/markdown-mode)
- [nyan-mode](https://github.com/TeMPOraL/nyan-mode)
- [python-mode](https://github.com/jorgenschaefer/elpy)
- [yaml-mode](https://github.com/yoshiki/yaml-mode)
