(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

;; markdown!
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(tool-bar-mode -1)
(column-number-mode +1)
(show-paren-mode +1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)

(require 'copy-line)
(define-key global-map (kbd "C-c k") 'kill-whole-line)
(define-key global-map (kbd "C-c C-k") 'copy-line)

(define-key global-map (kbd "C-c C-=") 'align-regexp)

;; mutt mail-mode stuff
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

(require 'package)
(add-to-list 'package-archives 
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/")
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(package-initialize)

 (if window-system
   (progn
     (load-theme 'spolsky t)))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
