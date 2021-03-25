;; setup packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(setq inhibit-startup-screen t)

(delete-selection-mode 1)

(electric-pair-mode 1)

;; this keymap suspends the emacs process, and I don't ever do it intentionally.
(global-unset-key (kbd "C-z"))

(add-to-list 'default-frame-alist '(font . "Input 12" ))
(set-face-attribute 'default t :font "Input 12" )

(setq backup-directory-alist '(("." . "~/.emacs-saves")))

(global-auto-revert-mode 1)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'better-defaults)
(menu-bar-mode 1)

(global-hl-line-mode 1)

;; fix the upcase and downcase commands to use the 'do what i mean' versions
(global-set-key (kbd "M-u") 'upcase-dwim)
(global-set-key (kbd "M-l") 'downcase-dwim)

(load-theme 'doom-gruvbox)
(doom-themes-visual-bell-config)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


(exec-path-from-shell-initialize)

(global-display-line-numbers-mode 1)
(column-number-mode 1)

(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x C-g") 'counsel-git)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "s-r") 'counsel-imenu)
(global-set-key (kbd "s-F") 'counsel-rg)

(evil-mode 1)
(global-evil-surround-mode 1)
(evil-commentary-mode)

(load "~/.emacs.d/site-lisp/my-org.el")
