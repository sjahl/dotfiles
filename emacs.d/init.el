;; load paths
(add-to-list 'load-path "~/.emacs.d/plugins/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; interface
(tool-bar-mode -1)
(column-number-mode +1)
(show-paren-mode +1)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)

;; mutt mail-mode stuff
(setq auto-mode-alist (append '(("/tmp/mutt.*" . mail-mode)) auto-mode-alist))

;; package archives
(require 'package)
(add-to-list 'package-archives 
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/")
	     '("marmalade" .
	       "http://marmalade-repo.org/packages/"))
(package-initialize)

 (if window-system
   (progn
     (load-theme 'sanityinc-tomorrow-night t)))

;; keybindings
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c SPC") 'avy-goto-word-or-subword-1)
(require 'copy-line)
(define-key global-map (kbd "C-c k") 'kill-whole-line)
(define-key global-map (kbd "C-c C-k") 'copy-line)
