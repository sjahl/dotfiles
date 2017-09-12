;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

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
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(vertical-border ((t (:foreground "#5a5a5a")))))

;; linting

(add-hook 'after-init-hook #'global-flycheck-mode)

;(pyvenv-mode)

;; niceties for hilighting numbers
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; Projectile
(projectile-global-mode)

;; hl-line
(global-hl-line-mode)

;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;; highlight-parentheses
;; (global-highlight-parentheses-mode)

;; nicer looking ido and better M-x
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(global-set-key (kbd "M-x") 'smex)

;; theme

;; (if window-system
;;     (progn
;;       (load-theme 'spacemacs-dark t)))
;; (setq spacemacs-theme-comment-bg nil)
(load-theme 'doom-one t)


; move quick-help tooltips to the minibuffer
(setq jedi:tooltip-method nil)

(add-hook 'python-mode-hook 'jedi:setup)
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

;; be evil.
;;(setq evil-want-C-u-scroll t)
;;(evil-mode 1)
;;(evil-commentary-mode)
;;(global-evil-surround-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (rust-mode go-mode afternoon-theme badger-theme idea-darkula-theme jbeans-theme kaolin-theme oceanic-theme sublime-themes expand-region spacemacs-theme dracula-theme molokai-theme doom-themes jedi company-jedi company material-theme yaml-mode window-numbering smex smart-mode-line pyenv-mode projectile nyan-mode markdown-mode magit json-mode jinja2-mode indent-guide ido-vertical-mode highlight-parentheses highlight-numbers flycheck fill-column-indicator exec-path-from-shell evil-surround evil-commentary base16-theme))))
