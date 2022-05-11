(require 'org)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(setq org-capture-templates
      '(("m" "MS5" entry (file+headline "~/sync/org/programming/ms5.org" "MS5 Timesheet")
         "** Working on Ms5 %<%Y-%m-%d>\nSCHEDULED: %t"
         :clock-in t
         :clock-keep t
         :jump-to-captured t
         )
        ("n" "Note" entry (file "~/sync/org/refile.org")
         "* %?")))


(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))
(setq org-default-notes-file (concat org-directory "~/sync/org/refile.org"))

(setq org-agenda-files (directory-files-recursively "~/sync/org" "\\.org$"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(doc-view-continuous t)
 '(org-agenda-files
   '("~/sync/org/programming/firebase.org" "~/sync/org/programming/ms5.org" "~/sync/org/programming/programming.org" "~/sync/org/programming/widgetbook.org" "~/sync/org/bible.org" "~/sync/org/books.org" "~/sync/org/fa22.org" "~/sync/org/kebre.org" "~/sync/org/life.org" "~/sync/org/phone_refile.org" "~/sync/org/refile.org" "~/sync/org/religious.org" "~/sync/org/sp22.org" "~/sync/org/todo.org" "~/sync/org/webnotes.org"))
 '(org-export-backends '(ascii beamer html icalendar latex md odt))
 '(package-selected-packages '(org-alert zenburn-theme use-package ##)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun org-export-output-file-name-modified (orig-fun extension &optional subtreep pub-dir)
  (unless pub-dir
    (setq pub-dir "~/Downloads/")
    (unless (file-directory-p pub-dir)
      (make-directory pub-dir)))
  (apply orig-fun extension subtreep pub-dir nil))
(advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)
(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "tex")))

(setq org-refile-targets
      '((nil :maxlevel . 3)
        (org-agenda-files :maxlevel . 3)))
