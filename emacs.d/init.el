;; setup packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(setq inhibit-startup-screen t)

(setq backup-directory-alist '(("." . "~/.emacs-saves")))

(global-auto-revert-mode 1)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'better-defaults)

(load-theme 'doom-dark+)
(doom-themes-visual-bell-config)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


(exec-path-from-shell-initialize)

(global-display-line-numbers-mode 1)
(column-number-mode 1)

(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-x C-g") 'counsel-git)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "s-r") 'counsel-imenu)

(load "~/.emacs.d/site-lisp/my-org.el")
