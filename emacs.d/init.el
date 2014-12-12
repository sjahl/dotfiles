(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(if (file-exists-p "~/.emacs.d/notmuch-config.el")
    (load-file "~/.emacs.d/notmuch-config.el"))

;; markdown!
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(tool-bar-mode -1)
; (electric-pair-mode +1)
(column-number-mode +1)
(show-paren-mode +1)

(require 'ido)
 (ido-mode t)
 (setq ido-enable-flex-matching t)

(require 'copy-line)
(define-key global-map (kbd "C-c k") 'kill-whole-line)
(define-key global-map (kbd "C-c C-k") 'copy-line)

(define-key global-map (kbd "C-c C-=") 'align-regexp)

(add-to-list 'auto-mode-alist '(".*mutt.*" . message-mode))
(setq mail-header-separator "")
(add-hook 'message-mode-hook 'auto-fill-mode)

(require 'package)
(add-to-list 'package-archives 
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/")
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(package-initialize)

(if window-system
    (progn
    (load-theme 'granger t)))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;(setq evil-want-C-u-scroll t)
;;(evil-mode 1)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(autoload 'notmuch "notmuch" "notmuch mail" t)

