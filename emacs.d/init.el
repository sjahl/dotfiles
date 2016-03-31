;; interface
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(show-paren-mode t)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq-default show-trailing-whitespace t)

;; behavior
(setq require-final-newline t)
(setq temporary-file-directory "~/.emacs.d/tmp/")
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; ido
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)

;; tls trust checking
(setq tls-checktrust 'ask)

;; package setup and installation
(load "~/.emacs.d/package-setup.el")

(if window-system
    (progn
      (load-theme 'spacemacs-dark t)))

;; general keybindings
(global-set-key (kbd "M--") 'er/expand-region)
(global-set-key (kbd "C-c SPC") 'avy-goto-char)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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

;; cmd-t
(global-set-key (kbd "M-t") 'helm-cmd-t)
