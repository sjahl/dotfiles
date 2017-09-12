(require 'package)
(setq package-archives
	     '(("melpa" .
		"https://melpa.org/packages/")
	       ("gnu" .
		"https://elpa.gnu.org/packages/")))
(package-initialize)

(setq package-list '(base16-theme
		     exec-path-from-shell
		     fill-column-indicator
		     flycheck
		     highlight-numbers
		     highlight-parentheses
		     indent-guide
		     json-mode
		     markdown-mode
		     nyan-mode
		     projectile
		     yaml-mode
		     jinja2-mode
		     magit
		     ido-vertical-mode
		     smex
		     window-numbering
		     evil
		     evil-commentary
		     evil-surround
		     smart-mode-line
		     pyenv-mode
		     doom-themes))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
