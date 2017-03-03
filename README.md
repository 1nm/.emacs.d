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

* [anzu](https://github.com/syohex/emacs-anzu)
* [auto-complete](https://github.com/auto-complete/auto-complete)
* [coffee-mode](https://github.com/defunkt/coffee-mode)
* [dockerfile-mode](https://github.com/spotify/dockerfile-mode)
* [exec-path-from-shell](https://github.com/purcell/exec-path-from-shell)
* [flycheck](https://github.com/flycheck/flycheck)
* [go-mode](https://github.com/dominikh/go-mode.el)
* [gradle-mode](https://github.com/jacobono/emacs-gradle-mode)
* [groovy-mode](https://github.com/Groovy-Emacs-Modes/groovy-emacs-modes)
* [helm](https://github.com/emacs-helm/helm)
* [helm-gtags](https://github.com/syohex/emacs-helm-gtags)
* [helm-projectile](https://github.com/bbatsov/helm-projectile)
* [helm-pydoc](https://github.com/syohex/emacs-helm-pydoc)
* [highlight-symbol](https://github.com/nschum/highlight-symbol.el)
* [json-mode](https://github.com/joshwnj/json-mode)
* [magit](https://github.com/magit/magit)
* [markdown-mode](https://github.com/jrblevin/markdown-mode)
* [nyan-mode](https://github.com/TeMPOraL/nyan-mode)
* [python-mode](https://github.com/jorgenschaefer/elpy)
* [scala-mode](https://github.com/ensime/emacs-scala-mode)
* [yaml-mode](https://github.com/yoshiki/yaml-mode)
* [yasnippet](https://github.com/joaotavora/yasnippet)
