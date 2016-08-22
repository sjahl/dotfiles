(require 'package)
(setq package-archives
	     '(("melpa" .
		"https://melpa.org/packages/")
	       ("gnu" .
		"https://elpa.gnu.org/packages/")))
(package-initialize)

(setq package-list '(avy
		     base16-theme
		     color-theme-sanityinc-tomorrow
		     darktooth-theme
		     exec-path-from-shell
		     expand-region
		     fill-column-indicator
		     flycheck
		     highlight-numbers
		     json-mode
		     markdown-mode
		     multiple-cursors
		     nyan-mode
		     python-mode
		     spacemacs-theme
		     virtualenvwrapper
		     projectile
		     yaml-mode))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
