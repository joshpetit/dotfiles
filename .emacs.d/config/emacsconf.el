(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)


(setq alert-default-style 'libnotify)
(load-theme 'zenburn t)
(require 'evil)
(evil-mode 1)

(setq alert-default-style 'libnotify)
(global-set-key (kbd "C-c r") (lambda () (interactive) (load "~/.emacs.d/init.el")))

;; -*- mode: elisp -*-

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode

(global-auto-revert-mode t)

