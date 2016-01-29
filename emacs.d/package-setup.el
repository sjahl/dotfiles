(require 'package)
(setq package-archives
	     '(("melpa" .
		"https://melpa.milkbox.net/packages/")
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
		     flymake-python-pyflakes
		     helm
		     helm-cmd-t
		     helm-git-grep
		     helm-ls-git
		     jedi
		     markdown-mode
		     multiple-cursors
		     nyan-mode
		     python-mode
		     spacemacs-theme
		     yaml-mode))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))