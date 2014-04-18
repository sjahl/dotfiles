(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

(tool-bar-mode -1)
(electric-pair-mode +1)
(column-number-mode +1)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(require 'copy-line)
(define-key global-map (kbd "C-c k") 'kill-whole-line)
(define-key global-map (kbd "C-c C-k") 'copy-line)

(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/")
    '("melpa" .
      "http://melpa.milkbox.net/packages/"))
(package-initialize)

(if window-system
    (load-theme 'solarized-dark t))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
