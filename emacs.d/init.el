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
      (load-theme 'tomorrow-night t)
;;       ;; Mode line setup
;; (setq-default
;;  mode-line-format
;;  '(; Position, including warning for 80 columns
;;    "  "
;;    (:propertize "%4l:" face mode-line-position-face)
;;    (:eval (propertize "%3c" 'face
;;                       (if (>= (current-column) 80)
;;                           'mode-line-80col-face
;;                         'mode-line-position-face)))
;;    ; emacsclient [default -- keep?]
;;    mode-line-client
;;    "  "
;;    ; read-only or modified status
;;    (:eval
;;     (cond (buffer-read-only
;;            (propertize " RO " 'face 'mode-line-read-only-face))
;;           ((buffer-modified-p)
;;            (propertize " ** " 'face 'mode-line-modified-face))
;;           (t "      ")))
;;    "    "
;;    ; directory and buffer/file name
;;    (:propertize "%b"
;;                 face mode-line-filename-face)
;;    ; narrow [default -- keep?]
;;    " %n "
;;    ; mode indicators: vc, recursive edit, major mode, minor modes, process, global
;;    (vc-mode vc-mode)
;;    "  %["
;;    (:propertize mode-name
;;                 face mode-line-mode-face)
;;    "%] "
;;    (:eval (propertize (format-mode-line minor-mode-alist)
;;                       'face 'mode-line-minor-mode-face))
;;    (:propertize mode-line-process
;;                 face mode-line-process-face)
;;    (global-mode-string global-mode-string)
;;    "    "
;;    ; nyan-mode uses nyan cat as an alternative to %p
;;    (:eval (when nyan-mode (list (nyan-create))))
;;    ))


;; ;; Extra mode line faces
;; (make-face 'mode-line-read-only-face)
;; (make-face 'mode-line-modified-face)
;; (make-face 'mode-line-folder-face)
;; (make-face 'mode-line-filename-face)
;; (make-face 'mode-line-position-face)
;; (make-face 'mode-line-mode-face)
;; (make-face 'mode-line-minor-mode-face)
;; (make-face 'mode-line-process-face)
;; (make-face 'mode-line-80col-face)

;; (set-face-attribute 'mode-line nil
;;     :foreground "gray60" :background "#353942"
;;     :inverse-video nil
;;     :box '(:line-width 6 :color "#353942" :style nil))
;; (set-face-attribute 'mode-line-inactive nil
;;     :foreground "gray80" :background "gray20"
;;     :inverse-video nil
;;     :box '(:line-width 6 :color "gray20" :style nil))

;; (set-face-attribute 'mode-line-read-only-face nil
;;     :inherit 'mode-line-face
;;     :foreground "#4271ae"
;;     :box '(:line-width 2 :color "#4271ae"))
;; (set-face-attribute 'mode-line-modified-face nil
;;     :inherit 'mode-line-face
;;     :foreground "#c82829"
;;     :background "#ffffff"
;;     :box '(:line-width 2 :color "#c82829"))
;; (set-face-attribute 'mode-line-folder-face nil
;;     :inherit 'mode-line-face
;;     :foreground "gray60")
;; (set-face-attribute 'mode-line-filename-face nil
;;     :inherit 'mode-line-face
;;     :foreground "#eab700"
;;     :weight 'bold)
;; (set-face-attribute 'mode-line-position-face nil
;;     :inherit 'mode-line-face
;;     :height 100)
;; (set-face-attribute 'mode-line-mode-face nil
;;     :inherit 'mode-line-face
;;     :foreground "gray80")
;; (set-face-attribute 'mode-line-minor-mode-face nil
;;     :inherit 'mode-line-mode-face
;;     :foreground "gray40"
;;     :height 110)
;; (set-face-attribute 'mode-line-process-face nil
;;     :inherit 'mode-line-face
;;     :foreground "#718c00")
;; (set-face-attribute 'mode-line-80col-face nil
;;     :inherit 'mode-line-position-face
;;     :foreground "black" :background "#eab700")

))

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

;; virtualenvs
(require 'virtualenvwrapper)
(setq venv-location "~/.virtualenvs")

;; niceties for hilighting numbers
;; (add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; Projectile
(projectile-global-mode)

(defun git-grep ()
  "Grep for a symbol within the git repo of the current file."
  (interactive)
  (let* ((sym (thing-at-point 'symbol))
         (regex (read-regexp "Expression" sym)))
    (require 'vc-git)
    (vc-git-grep regex  "" (vc-git-root default-directory))))
  
;; I (Scott) bind this to CTRL-C g.
(global-set-key "\C-cg" 'git-grep)
