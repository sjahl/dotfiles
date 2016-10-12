(require 'package)
(setq package-archives
	     '(("melpa" .
		"https://melpa.org/packages/")
	       ("gnu" .
		"https://elpa.gnu.org/packages/")))
(package-initialize)

(setq package-list '(avy
		     base16-theme
		     exec-path-from-shell
		     expand-region
		     fill-column-indicator
		     flycheck
		     highlight-numbers
		     highlight-parentheses
		     json-mode
		     markdown-mode
		     multiple-cursors
		     nyan-mode
		     pyvenv
		     projectile
		     magit
		     yaml-mode
		     jinja2-mode
		     magit
		     ido-vertical-mode
		     jedi
		     smex
		     window-numbering
		     spaceline))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
