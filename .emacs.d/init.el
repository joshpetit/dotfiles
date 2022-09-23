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

(use-package zenburn-theme
             )

(use-package ivy-omni-org
             :config
             (setq ivy-omni-org-file-sources '(org-agenda-files))
             )

(use-package darkroom
             )

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
             (ivy-mode)
 )
(use-package counsel
 :bind (("M-x" . counsel-M-x))
 )
(global-set-key (kbd "C-x C-f") 'counsel-find-file)


(use-package evil
             :init
             :config
             (evil-set-leader 'normal (kbd "SPC"))
             (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
             (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
             (define-key evil-normal-state-map (kbd "C-k") 'evil-window-top)
             (define-key evil-normal-state-map (kbd "C-j") 'evil-window-bottom)
             (define-key evil-normal-state-map (kbd "<leader>w") 'save-buffer)
             (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
             (define-key evil-normal-state-map (kbd "<leader>of") 'ivy-omni-org)
             (define-key evil-normal-state-map (kbd "TAB") 'outline-cycle)
             (define-key evil-normal-state-map (kbd "<F11>") 'darkroom-mode)
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
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-agenda-files (directory-files-recursively "~/sync/org/" "\\.org$"))
(setq org-directory "~/sync/org/")
(setq org-export-backends '(ascii beamer html icalendar latex md odt))
(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))

(setq org-refile-targets
      '((nil :maxlevel . 3)
        (org-agenda-files :maxlevel . 3)))

(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)
;(advice-add org-refile :after 'org-save-all-org-buffers)


(defun async-shell-command-to-string (command callback)
  "Execute shell command COMMAND asynchronously in the
  background.

  Return the temporary output buffer which command is writing to
  during execution.

  When the command is finished, call CALLBACK with the resulting
  output as a string."
  (let
    ((output-buffer (generate-new-buffer " *temp*"))
     (callback-fun callback))
    (set-process-sentinel
      (start-process "Shell" output-buffer shell-file-name shell-command-switch command)
      (lambda (process signal)
        (when (memq (process-status process) '(exit signal))
          (with-current-buffer output-buffer
                               (let ((output-string
                                       (buffer-substring-no-properties
                                         (point-min)
                                         (point-max))))
                                 (funcall callback-fun (string-trim output-string))))
          (kill-buffer output-buffer))))
    output-buffer))


(setq org-confirm-babel-evaluate 0)
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
           (_ path)))

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

  (add-hook! 'org-open-at-point-functions #'open-custom-link-h)

  )
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

(setq backup-directory-alist `(("." . "~/.saves")))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(scroll-bar-mode 0) 

(add-hook 'org-clock-in-hook #'save-buffer)
(add-hook 'org-clock-out-hook #'save-buffer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/home/joshu/sync/org/programming/firebase.org" "/home/joshu/sync/org/programming/ms5.org" "/home/joshu/sync/org/programming/widgetbook.org" "/home/joshu/sync/org/bible.org" "/home/joshu/sync/org/books.org" "/home/joshu/sync/org/fa22.org" "/home/joshu/sync/org/kebre.org" "/home/joshu/sync/org/life.org" "/home/joshu/sync/org/ministers.org" "/home/joshu/sync/org/ministry.org" "/home/joshu/sync/org/music.org" "/home/joshu/sync/org/notes.org" "/home/joshu/sync/org/phone_refile.org" "/home/joshu/sync/org/prayers.org" "/home/joshu/sync/org/programming.org" "/home/joshu/sync/org/projects.org" "/home/joshu/sync/org/refile.org" "/home/joshu/sync/org/reflections.org" "/home/joshu/sync/org/religious.org" "/home/joshu/sync/org/retreat.org" "/home/joshu/sync/org/sabbath.org" "/home/joshu/sync/org/sermons.org" "/home/joshu/sync/org/sp22.org" "/home/joshu/sync/org/todo.org" "/home/joshu/sync/org/trianglesda.org" "/home/joshu/sync/org/vespers.org" "/home/joshu/sync/org/webnotes.org" "/home/joshu/sync/org/what-is-christianity.org" "/home/joshu/sync/org/work.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
