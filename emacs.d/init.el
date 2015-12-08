;; load paths
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; interface
(tool-bar-mode -1)
(column-number-mode t)
(show-paren-mode t)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;; ido
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)

;; mutt mail-mode stuff
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

;; tls trust checking
(setq tls-checktrust 'ask)

;; package archives
(require 'package)
(setq package-archives 
	     '(("melpa" .
		"https://melpa.milkbox.net/packages/")
	       ;; ("marmalade" .
	       ;; 	"https://marmalade-repo.org/packages/")
	       ("gnu" .
		"https://elpa.gnu.org/packages/")))
(package-initialize)

;; (if window-system
;;     (progn
;;       (load-theme 'sanityinc-tomorrow-night t)))

;; colors
(load-theme 'base16-default-dark t)

;; keybindings
(global-set-key (kbd "M--") 'er/expand-region)
(global-set-key (kbd "C-c SPC") 'avy-goto-char)
(require 'copy-line)
(define-key global-map (kbd "C-c k") 'kill-whole-line)
(define-key global-map (kbd "C-c C-k") 'copy-line)

;; flymake
(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(setq flymake-python-pyflakes-executable "/usr/local/bin/flake8")

;; get path from shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
