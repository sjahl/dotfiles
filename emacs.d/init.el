;; interface

(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(show-paren-mode t)
(electric-pair-mode t)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq-default show-trailing-whitespace t)

;; behavior
(setq temporary-file-directory "~/.emacs.d/tmp/")
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(put 'downcase-region 'disabled nil)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'auto-mode-alist '(".j2$" . jinja2-mode))

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.
  \(fn arg char)"
  'interactive)

(global-set-key "\M-z" 'zap-up-to-char)


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
      (exec-path-from-shell-initialize)))

;; use a dark gray border between panes
(custom-set-faces
 '(vertical-border ((t (:foreground "#5a5a5a"))))
 )

;; general keybindings
(global-set-key (kbd "M--") 'er/expand-region)
(global-set-key (kbd "C-c SPC") 'avy-goto-char)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "M-t") 'helm-cmd-t)

;; linting

(add-hook 'after-init-hook #'global-flycheck-mode)

(pyvenv-mode)

;; niceties for hilighting numbers
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; Projectile
(projectile-global-mode)

;; hl-line
(global-hl-line-mode)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:get-in-function-call-delay 10000000)
(setq jedi:complete-on-dot t)

(defun git-grep ()
  "Grep for a symbol within the git repo of the current file."
  (interactive)
  (let* ((sym (thing-at-point 'symbol))
         (regex (read-regexp "Expression" sym)))
    (require 'vc-git)
    (vc-git-grep regex  "" (vc-git-root default-directory))))

;; I (Scott) bind this to CTRL-C g.
(global-set-key "\C-cg" 'git-grep)

;; magit keybinding
(global-set-key (kbd "C-x g") 'magit-status)

;; nicer looking ido and better M-x
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(global-set-key (kbd "M-x") 'smex)

;; theme
(load-theme 'base16-tomorrow-night t)
(window-numbering-mode 1)
(defun window-numbering-install-mode-line (&optional position)
  "Do nothing.")
(setq powerline-default-separator nil)
(require 'spaceline-config)
(spaceline-emacs-theme)
