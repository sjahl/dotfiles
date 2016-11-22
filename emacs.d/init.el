;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "c6bac01425701418ca444aa68a6e88f671797fc43299a9a84be3d3a8557dd308" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (molokai-theme smart-mode-line-powerline-theme indent-guide vi-tilde-fringe jbeans-theme evil evil-commentary evil-surround tabbar-ruler tabbar spaceline window-numbering smex jedi ido-vertical-mode jinja2-mode yaml-mode magit projectile pyvenv nyan-mode markdown-mode json-mode highlight-parentheses highlight-numbers flycheck fill-column-indicator exec-path-from-shell base16-theme avy))))

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
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vertical-border ((t (:foreground "#5a5a5a")))))

;; linting

(add-hook 'after-init-hook #'global-flycheck-mode)

;(pyvenv-mode)

;; niceties for hilighting numbers
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; Projectile
(projectile-global-mode)

;; hl-line
(global-hl-line-mode)

;; highlight-parentheses
(global-highlight-parentheses-mode)

(defun git-grep ()
  "Grep for a symbol within the git repo of the current file."
  (interactive)
  (let* ((sym (thing-at-point 'symbol))
         (regex (read-regexp "Expression" sym)))
    (require 'vc-git)
    (vc-git-grep regex  "" (vc-git-root default-directory))))

;; I (Scott) bind this to CTRL-C g.
(global-set-key "\C-cg" 'git-grep)

;; nicer looking ido and better M-x
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(global-set-key (kbd "M-x") 'smex)

;; theme

(if window-system
    (progn
      (load-theme 'atom-one-dark t)
      (global-linum-mode 1)))

;; indent-guide
(indent-guide-global-mode)

;; be evil.
(setq evil-want-C-u-scroll t)
(evil-mode 1)
(evil-commentary-mode)
(global-evil-surround-mode 1)

;; sml
(sml/setup)
(add-to-list 'rm-excluded-modes " ing")
(add-to-list 'rm-excluded-modes " Undo-Tree")
(add-to-list 'rm-excluded-modes " s-/")
