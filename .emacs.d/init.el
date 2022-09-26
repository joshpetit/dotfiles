;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(set-face-attribute 'default nil :font "InconsolataGo Nerd Font" :height 115)

(setq use-package-always-ensure t)

(use-package zenburn-theme)

(use-package prescient)
(use-package ivy-prescient

             :config
             (ivy-prescient-mode 1)
             )
(use-package general)

(use-package ivy-omni-org
             :config
             (setq ivy-omni-org-file-sources '(org-agenda-files))
             )

(use-package darkroom)

(use-package ivy
             :diminish
             :bind (("C-s" . swiper)
                    :map ivy-minibuffer-map
                    ("TAB" . ivy-alt-done)
                    ("RET" . ivy-alt-done)
                    ("C-l" . ivy-alt-done)
                    ("C-j" . ivy-next-line)
                    ("C-k" . ivy-previous-line)
                    ("C-w" . ivy-backward-kill-word)
                    :map ivy-switch-buffer-map
                    ("C-k" . ivy-previous-line)
                    ("C-l" . ivy-one)
                    ("C-d" . ivy-switch-buffer-kill)
                    :map ivy-reverse-i-search-map
                    ("C-k" . ivy-previous-line)
                    ("C-d" . ivy-reverse-i-search-kill))

             :config
             (setq ivy-initial-inputs-alist nil)
	     (setq case-fold-search t)
             (ivy-mode)
             )

(use-package counsel
             :bind (("M-x" . counsel-M-x)
                    ("<leader>of" . (lambda () (interactive) (counsel-find-file "~/sync/org")))
                    ("<leader>oH" . counsel-org-agenda-headlines)
                    ("<leader>oh" . counsel-outline)
                    )
             )

(use-package evil
             :init
             (setq evil-want-C-i-jump nil)
             :config
             (evil-set-leader 'normal (kbd "SPC"))
             (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
             (define-key evil-normal-state-map (kbd "TAB") 'outline-cycle)
             (define-key evil-normal-state-map (kbd "RET") 'org-open-at-point)
             (define-key evil-normal-state-map (kbd "K") 'describe-function)
             )

(use-package evil-org
             :after org
             :hook (org-mode . (lambda () evil-org-mode))
             :config
             (require 'evil-org)
             (require 'evil-org-agenda)
             (evil-org-agenda-set-keys)
             (evil-org-set-key-theme '(navigation insert textobjects additional calendar)))
(use-package ivy-rich
             :init
             (ivy-rich-mode 1))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(load-theme 'zenburn t)
(setq org-agenda-files (directory-files-recursively "~/sync/org/" "\\.org$"))
(setq org-directory "~/sync/org/")
(setq org-export-backends '(ascii beamer html icalendar latex md odt))
(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))

(setq org-refile-targets
      '((nil :maxlevel . 3)
        (org-agenda-files :maxlevel . 3)))

(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)


(defun my-org-confirm-babel-evaluate (lang body)
   (string= lang "ditaa"))  ;if a ditaa langauge exists ask for it lol
(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages
  'org-babel-load-languages (quote (
                                    (sqlite . t)
                                    (plantuml . t))))
(setq org-plantuml-jar-path
      (expand-file-name "~/apps/plantuml.jar"))

(setq org-capture-templates
      '(("m" "MS5" entry (file+headline "~/sync/org/programming/ms5.org" "MS5 Timesheet")
         "** Working on Ms5 %<%Y-%m-%d>\nSCHEDULED: %t"
         :clock-in t
         :clock-keep t
         :jump-to-captured t
         )
        ("n" "Note" entry (file "~/sync/org/refile.org")
         "* %?")
        ("t" "MS5 Task" entry (file+headline "~/sync/org/programming/ms5.org" "MS5 Refile")
         "** %?\nSCHEDULED: %t")
        ("w" "Work" entry (file+headline "~/sync/org/work.org" "Working on Ms5 %<%Y-%m-%d>")
         "*** %?"
         :clock-in t
         :clock-keep t
         :jump-to-captured t
         )))



(org-link-set-parameters "asset" :follow #'org-blog-asset-follow :export #'org-blog-asset-export)

(defun org-blog-asset-follow (path)
  (org-open-file
    (format "./%s" path)))

(defun org-blog-asset-export (link description format _)
  "Export a man page link from Org files."
  "Docs here https://orgmode.org/manual/Adding-Hyperlink-Types.html"
  (let ((link (replace-regexp-in-string " " "%20" link))
        (url (format "http://joshministers.com/static/%s" link))
        (desc (or description link)))
    (pcase format
           (`html (format "<a target=\"_blank\" href=\"%s\">%s</a>" url desc))
           (`latex (format "\\href{%s}{%s}" url desc))
           (`texinfo (format "@uref{%s,%s}" url desc))
           (`ascii (format "%s (%s)" desc url))
           (`md (format "[%s](/static/%s)" desc link))
           (_ path))))

(org-link-set-parameters "img-asset" :follow #'org-blog-asset-follow :export #'org-blog-img-asset-export)


(defun org-blog-img-asset-export (link description format _)
  (let ((url (format "http://man.he.net/?topic=%s&section=all" link))
        (desc (or description link)))
    (pcase format
           (`html (format "<img src=\"/static/%s\" alt=\"%s\">" link desc))
           (`latex (format "\includegraphics[width=.9\linewidth]{%s}" link desc))
           (`texinfo (format "@uref{%s,%s}" url desc))
           (`ascii (format "%s (%s)" desc url))
           (`md (format "![%s](/static/%s)" desc link))
           (_ path))))

(org-link-set-parameters "post" :follow #'org-blog-post-follow :export #'org-blog-post-export)

(defun org-blog-post-follow (path)
  (org-open-file
    (format "./%s" path)))


(defun org-blog-post-export (link description format _)
  (let ((url (format "/blog/%s" link))
        (desc (or description link)))
    (pcase format
           (`html (format "<a target=\"_blank\" href=\"%s\">%s</a>" url desc))
           (`latex (format "\\href{%s}{%s}" url desc))
           (`texinfo (format "@uref{%s,%s}" url desc))
           (`ascii (format "%s (%s)" desc url))
           (`md (format "[%s](/static/%s)" desc link))
           (_ path))))

(org-link-set-parameters "bible" :follow #'org-bible-follow :export #'org-bible-export)


(defun org-bible-follow (passage)
  (let* ((cooler-passage (replace-regexp-in-string "^\\(.+[0-9]\\)\\s-\\(.*\\)" "\\1,\\2" passage))
         (split-passage (split-string cooler-passage ","))
         (bible-version (or (nth 1 split-passage) "NASB"))
         (reference-normal (nth 0 split-passage))
         (choices '(("open in browser" . "goto-bible-reference") ("copy scripture" . "copy-scripture")))
         (reference (replace-regexp-in-string " " "\+" (nth 0 split-passage)))
         (url "https://www.biblegateway.com/bible?language=en&version=%s&passage=%s")
         (choice (alist-get (completing-read "Choose: " choices) choices nil nil 'equal)))
    (funcall (intern choice) bible-version reference-normal)))

(defun goto-bible-reference (bible-version reference)
  (browse-url (format  "https://www.biblegateway.com/bible?language=en&version=%s&passage=%s" bible-version reference)))

(defun copy-scripture (bible-version reference-normal)
  (evil-set-register ?\"  ;"
                     (shell-command-to-string (concat "bible " reference-normal " --version " bible-version " --verse-numbers")
                                              )))

(defun org-bible-export (passage description format _)
  (let* ((cooler-passage (replace-regexp-in-string "^\\(.+[0-9]\\)\\s-\\(.*\\)" "\\1,\\2" passage))
         (split-passage (split-string cooler-passage ","))
         (bible-version (or (nth 1 split-passage) "NKJV"))
         (reference (nth 0 split-passage))
         (reference-clean (replace-regexp-in-string " " "\+" (nth 0 split-passage)))
         (link (format "https://www.biblegateway.com/bible?language=en&version=%s&passage=%s" bible-version reference-clean))
         (desc  (format "%s (%s)" reference bible-version))
         )
    (pcase format
           (`html (format "<a target=\"_blank\" href=\"%s\">%s</a>" link desc))
           (`latex (format "\\textbf{\\href{%s}{%s}}" link desc))
           (`texinfo (format "@uref{%s,%s}" link desc))
           (`ascii (format "%s (%s)" desc link))
           (`md (format "**[%s](%s)**" desc link))
           (_ path))))

(defun is-link-of-type (link prefix)
  (when (string-match (rx (literal prefix)
                          ":"
                          (group (1+ anything))) link)
    t))

(defun get-link-type (link)
  (when (string-match (rx (group (1+ (not ":")))
                          ":"
                          (1+ anything)) link)
    (match-string 1 link)))
(defun omit-link-type (link)
  (when (string-match (rx (0+ (not ":"))
                          ":"
                          (group (1+ anything))) link)
    (match-string 1 link)))

(defun bible-protocol-open (passage)
  (let* ((cooler-passage (replace-regexp-in-string "^\\(.+[0-9]\\)\\s-\\(.*\\)" "\\1,\\2" passage))
         (split-passage (split-string cooler-passage ","))
         (bible-version (or (nth 1 split-passage) "NKJC"))
         (reference-normal (nth 0 split-passage))
         (reference (replace-regexp-in-string " " "\+" (nth 0 split-passage)))
         (url "https://www.biblegateway.com/bible?language=en&version=%s&passage=%s")
         )
    (evil-set-register ?\"  ;"
                       (shell-command-to-string (concat "bible " reference-normal " --version " bible-version " --verse-numbers")
                                                ))))

(defvar +custom/org-find-file-at-mouse-called nil
  "Indicates if the `org-open-at-point' was call through `org-find-file-at-mouse'")

(defun org-find-file-at-mouse-a (fn &rest args)
  (setq +custom/org-find-file-at-mouse-called t)
  (prog1 (apply fn args)
    (setq +custom/org-find-file-at-mouse-called nil)))

(advice-add #'org-find-file-at-mouse :around #'org-find-file-at-mouse-a)

(defun open-custom-link-h ()
  (when +custom/org-find-file-at-mouse-called
    (let* ((context
             ;; Only consider supported types, even if they are not the
             ;; closest one.
             (org-element-lineage
               (org-element-context)
               '(link)
               t))
           (type (org-element-type context))
           (raw-link (org-element-property :raw-link context)))
      (when (eq type 'link)
        (let* ((address (omit-link-type raw-link))
               (link-protocol (get-link-type raw-link)))
          (pcase link-protocol
                 ("bible" (bible-protocol-open address))
                 ("stop" (message "Lol cool"))
                 ))))))

;(add-hook 'org-open-at-point-functions #'open-custom-link-h)
(setq org-agenda-custom-commands
      '(("X" agenda ""
         ((ps-number-of-columns 2)
          (ps-landscape-mode t)
          (org-agenda-span (quote day))
          (org-agenda-with-colors nil)
          (org-agenda-remove-tags t))
         ("agenda"))))

(add-hook 'text-mode-hook #'auto-fill-mode)
(setq-default fill-column 80)

(setq select-enable-clipboard nil)

(setq confirm-kill-emacs nil)

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)

(global-set-key (kbd "C-c r") (lambda () (interactive) (load "~/.emacs.d/init.el")))
(global-set-key "\C-ca" 'org-agenda)

(setq backup-directory-alist `(("." . "~/.local/share/emacs/saves")))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "<f9>") 'darkroom-mode)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "M-h") 'org-do-promote)
(global-unset-key (kbd "M-l"))
(global-set-key (kbd "M-l") 'org-do-demote)

(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(scroll-bar-mode 0) 
(tool-bar-mode 0) 

(add-hook 'org-clock-in-hook #'save-buffer)
(add-hook 'org-clock-out-hook #'save-buffer)
(add-hook 'text-mode-hook 'visual-line-mode)
(advice-add 'org-refile :after
            (lambda (&rest _)
              (org-save-all-org-buffers)))

(general-define-key
 :keymaps 'org-mode-map
 "M-h" 'org-do-promote
 )

;(global-set-key (kbd "SPC") 'jp/space-keymap)

(general-define-key
 "<leader>a" 'org-agenda
 "C-l" 'evil-window-right
 "C-h" 'evil-window-left
 "C-k" 'evil-window-up
 "C-j" 'evil-window-down
 "<leader>w" 'save-buffer
 "C-u" 'evil-scroll-up
 ;"SPC oa" 'org-agenda
 )

(setq org-export-headline-levels 5)

(defun jp/pandoc-export (src-block contents info)
  (let ((res (org-export-with-backend 'latex src-block contents info)))))

(setq make-backup-files nil)
