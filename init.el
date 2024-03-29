(add-to-list 'load-path "/usr/share/org-mode/lisp/")
;;  (add-to-list 'load-path "/home/alegrand/Work/org-mode/install/org-mode/emacs/site-lisp/org/")

(require 'package)
(package-initialize)
(setq package-archives
'(("ELPA" . "http://tromey.com/elpa/")
   ("gnu" . "http://elpa.gnu.org/packages/")
   ("melpa" . "http://melpa.milkbox.net/packages/")
   ("marmalade" . "http://marmalade-repo.org/packages/")))

(add-to-list 'load-path "~/lib/elisp/")
;; (add-to-list 'load-path "~/.emacs.d/elpa/org-20150302/")
(add-to-list 'load-path "~/.emacs.d/elpa/xclip-1.3/")
;; (add-to-list 'load-path "~/.emacs.d/elpa/htmlize-20130207.1202/")
(add-to-list 'load-path "~/.emacs.d/elpa/polymode-20151013.814/")
(add-to-list 'load-path "~/.emacs.d/elpa/lua-mode-20150518.942/")
(add-to-list 'load-path "~/.emacs.d/elpa/toc-org-20150801.748/")
(add-to-list 'load-path "~/.emacs.d/elpa/epresent-20150324.610/")

(require 'org-install)
(require 'org)
;; (require 'org-html)

(require 'font-lock)
(require 'cc-mode)
(c-after-font-lock-init)

(setq auto-mode-alist
   (append (mapcar 'purecopy
      '(("\\.c$"   . c-mode)
	("\\.h$"   . c-mode)
	("\\.c.simp$" . c-mode)
	("\\.h.simp$" . c-mode)
	("\\.a$"   . c-mode)
	("\\.w$"   . cweb-mode)
	("\\.cc$"   . c++-mode)
	("\\.S$"   . asm-mode)
	("\\.s$"   . asm-mode)
	("\\.p$"   . pascal-mode)
	("\\.Rmd$" . poly-markdown-mode)
	("\\.pas$" . pascal-mode)
	("\\.tex$" . LaTeX-mode)
	("\\.txi$" . Texinfo-mode)
	("\\.el$"  . emacs-lisp-mode)
	("emacs"  . emacs-lisp-mode)
	("\\.ml[iylp]?" . tuareg-mode)
	("[mM]akefile" . makefile-mode)
	("[mM]akefile.*" . makefile-mode)
	("\\.mak" . makefile-mode)
	("\\.cshrc" . sh-mode)
	("\\.html$" . html-mode)
        ("\\.org$" . org-mode)
)) auto-mode-alist))

(setq inhibit-splash-screen t)

(setq frame-title-format
  '("Emacs - " (buffer-file-name "%f"
    (dired-directory dired-directory "%b"))))

;; (set-default-font "9x15")
;; (set-frame-font "-1ASC-Droid Sans Mono-normal-normal-normal-*-*-*-*-*-m-0-iso10646-1")
(set-frame-font "-PfEd-DejaVu Sans Mono-normal-normal-normal-*-16-*-*-*-m-0-iso10646-1")

(global-font-lock-mode t)
(custom-set-faces
  '(flyspell-incorrect ((t (:inverse-video t)))))
;;  (set-face-attribute 'flyspell-incorrect (t (:inverse-video t)))

(line-number-mode 1)
(column-number-mode 1)

(load-library "paren")
(show-paren-mode 1)
(transient-mark-mode t)
(require 'paren)

(setq visible-bell t)

(global-set-key (kbd "C-c i")
(lambda() (interactive)(org-babel-load-file "~/.emacs.d/init.org")))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(cond
 ((string-equal system-type "darwin")   ; Mac OS X
  (progn
    (setq
     ns-command-modifier 'meta         ; Apple/Command key is Meta
	 ns-alternate-modifier nil         ; Option is the Mac Option key
	 ns-use-mac-modifier-symbols  nil  ; display standard Emacs (and not standard Mac) modifier symbols
	 ))
  )
 )

;; (cua-mode t)

(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <right>") 'hs-show-block)
    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
    (local-set-key (kbd "C-c <down>")  'hs-show-all)
    (hs-minor-mode t)))

(global-set-key [f5] '(lambda () (interactive) (revert-buffer nil t nil)))

(global-set-key "\^x\^e" 'compile)

(defun jump-mark ()
  (interactive)
  (set-mark-command (point)))
(defun beginning-of-defun-and-mark ()
  (interactive)
  (push-mark (point))
  (beginning-of-defun))
(defun end-of-defun-and-mark ()
  (interactive)
  (push-mark (point))
  (end-of-defun))

(global-set-key "\^c\^b" 'beginning-of-defun-and-mark)
(global-set-key "\^c\^e" 'end-of-defun-and-mark)
(global-set-key "\^c\^j" 'jump-mark)
(global-set-key [S-f6] 'jump-mark)		;; jump from mark to mark

(global-set-key "\M-g" 'goto-line)

(setq select-active-regions nil)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)
(setq mouse-drag-copy-region t)

;;  (if(string-equal system-type "gnu/linux")   ; Linux!
;;      (
       (require (quote xclip))
       (xclip-mode 1)
;;      )()
;;        )

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
;; C-x C-0 restores the default font size

;; Inspired from http://tex.stackexchange.com/questions/166681/changing-language-of-flyspell-emacs-with-a-shortcut
;; (defun spell (choice)
;;    "Switch between language dictionaries."
;;    (interactive "cChoose:  (a) American | (f) Francais")
;;     (cond ((eq choice ?1)
;;            (setq flyspell-default-dictionary "american")
;;            (setq ispell-dictionary "american")
;;            (ispell-kill-ispell))
;;           ((eq choice ?2)
;;            (setq flyspell-default-dictionary "francais")
;;            (setq ispell-dictionary "francais")
;;            (ispell-kill-ispell))
;;           (t (message "No changes have been made."))) )

(define-key global-map (kbd "C-c s a") (lambda () (interactive) (ispell-change-dictionary "american")))
(define-key global-map (kbd "C-c s f") (lambda () (interactive) (ispell-change-dictionary "francais")))
(define-key global-map (kbd "C-c s r") 'flyspell-region)
(define-key global-map (kbd "C-c s b") 'flyspell-buffer)
(define-key global-map (kbd "C-c s s") 'flyspell-mode)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
;; (global-magit-file-mode 1)

(define-key global-map (kbd "C-c w") 'visual-line-mode)

(defun auto-fill-mode-on () (TeX-PDF-mode 1))
(add-hook 'tex-mode-hook 'TeX-PDF-mode-on)
(add-hook 'latex-mode-hook 'TeX-PDF-mode-on)
(setq TeX-PDF-mode t)

(defun auto-fill-mode-on () (auto-fill-mode 1))
(add-hook 'text-mode-hook 'auto-fill-mode-on)
(add-hook 'emacs-lisp-mode 'auto-fill-mode-on)
(add-hook 'tex-mode-hook 'auto-fill-mode-on)
(add-hook 'latex-mode-hook 'auto-fill-mode-on)

(setq c-default-style "k&r")
(setq c-basic-offset 2)

(defun c-reformat-buffer()
   (interactive)
   (save-buffer)
   (setq sh-indent-command (concat
                            "indent -i2 -kr --no-tabs"
                            buffer-file-name
                            )
         )
   (mark-whole-buffer)
   (universal-argument)
   (shell-command-on-region
    (point-min)
    (point-max)
    sh-indent-command
    (buffer-name)
    )
   (save-buffer)
   )
 (define-key c-mode-base-map [f7] 'c-reformat-buffer)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq org-directory "~/org/")

(setq org-hide-leading-stars t)
(setq org-alphabetical-lists t)
(setq org-src-fontify-natively t)  ;; you want this to activate coloring in blocks
(setq org-src-tab-acts-natively t) ;; you want this to have completion in blocks
(setq org-hide-emphasis-markers t) ;; to hide the *,=, or / markers
(setq org-pretty-entities t)       ;; to have \alpha, \to and others display as utf8 http://orgmode.org/manual/Special-symbols.html

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-default-notes-file "~/org/notes.org")
     (define-key global-map "\C-cd" 'org-capture)
(setq org-capture-templates (quote (("t" "Todo" entry (file+headline "~/org/liste.org" "Tasks") "* TODO %?
  %i
  %a" :prepend t) ("j" "Journal" entry (file+datetree "~/org/journal.org") "* %?
Entered on %U
  %i
  %a"))))

(setq org-agenda-include-all-todo t)
(setq org-agenda-include-diary t)

(setq org-agenda-files (quote ("~/org/liste.org" "~/org/google.org")))
(setq revert-without-query (quote ("google.org")))

(setq org-id-method (quote uuidgen))

;; (global-visual-line-mode t)

;; see http://thread.gmane.org/gmane.emacs.orgmode/42715
(eval-after-load 'org-list
  '(add-hook 'org-checkbox-statistics-hook (function ndk/checkbox-list-complete)))

(defun ndk/checkbox-list-complete ()
  (save-excursion
    (org-back-to-heading t)
    (let ((beg (point)) end)
      (end-of-line)
      (setq end (point))
      (goto-char beg)
      (if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]" end t)
            (if (match-end 1)
                (if (equal (match-string 1) "100%")
                    ;; all done - do the state change
                    (org-todo 'done)
                  (org-todo 'todo))
              (if (and (> (match-end 2) (match-beginning 2))
                       (equal (match-string 2) (match-string 3)))
                  (org-todo 'done)
                (org-todo 'todo)))))))

(add-to-list 'load-path "~/.emacs.d/elpa/org-download-20171116.1045/")
(require 'org-download)
(setq org-download-method 'attach)
(global-set-key (kbd "C-c S") 'org-download-screenshot)

(global-set-key (kbd "C-c d") 'insert-date)
(defun insert-date (prefix)
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive "P")
    (let ((format (cond
                   ((not prefix) "** %Y-%m-%d")
                   ((equal prefix '(4)) "[%Y-%m-%d]"))))
      (insert (format-time-string format))))

(global-set-key (kbd "C-c t") 'insert-time-date)
(defun insert-time-date (prefix)
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive "P")
    (let ((format (cond
                   ((not prefix) "[%H:%M:%S; %d.%m.%Y]")
                   ((equal prefix '(4)) "[%H:%M:%S; %Y-%m-%d]"))))
      (insert (format-time-string format))))

(global-set-key (kbd "C-c v") 'org-show-todo-tree)

(global-set-key (kbd "C-c l") 'org-store-link)

;; (require 'org-git-link) ;; Made some personal modifications
;; (global-set-key (kbd "C-c g") 'org-git-insert-link-interactively)

(global-set-key (kbd "C-c e") (lambda ()
                  (interactive)
		  (insert "** data#\n*** git:\n#+begin_src sh\ngit log -1\n#+end_src\n*** Notes:" )))
		  ;;(insert "** data#\n[[shell:git log -1][git]]\n" )))
                  ;;(insert "** data#\n[[shell:git log -1][git]]\n" (format-time-string "[%H:%M:%S; %d.%m.%Y]" ))))

(global-set-key (kbd "C-c <up>") 'outline-up-heading)
(global-set-key (kbd "C-c <left>") 'outline-previous-visible-heading)
(global-set-key (kbd "C-c <right>") 'outline-next-visible-heading)

(defun org-goto-last-heading-in-tree ()
  (interactive)
  (org-forward-heading-same-level 1)     ; 1. Move to next tree
  (outline-previous-visible-heading 1)   ; 2. Move to last heading in previous tree
  (let ((org-special-ctrl-a/e t))        ; 3. Ignore tags when
    (org-end-of-line)))                  ;    moving to the end of the line
(define-key org-mode-map (kbd "C-c g") 'org-goto-last-heading-in-tree)
(defun goto-last-heading ()
  (interactive)
  (org-end-of-subtree))
(global-set-key (kbd "C-c <down>") 'goto-last-heading)

;; (setq org-export-babel-evaluate nil) ;; This is for org-mode<9 only. It breaks everything otherwise
;;  To activate this feature, you need to set #+PROPERTY: header-args :eval never-export in the beginning or your document
(setq org-confirm-babel-evaluate nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ocaml . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   (screen . t)
   (plantuml . t)
   (lilypond . t)
   (org . t)
   (makefile . t)
   ))
(setq org-src-preserve-indentation t)

(add-to-list 'org-structure-template-alist
        '("S" "#+begin_src ?\n\n#+end_src" "<src lang=\"?\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("m" "#+begin_src emacs-lisp\n\n#+end_src" "<src lang=\"emacs-lisp\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("r" "#+begin_src R :results output :session *R* :exports both\n\n#+end_src" "<src lang=\"R\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("rt" "#+begin_src R :colnames yes :results table :session *R* :exports both\n\n#+end_src" "<src lang=\"R\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("R" "#+begin_src R :results output graphics :file (org-babel-temp-file \"figure\" \".png\") :exports both :width 600 :height 400 :session *R* \n\n#+end_src" "<src lang=\"R\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("RR" "#+begin_src R :results output graphics :file  (org-babel-temp-file (concat (file-name-directory (or load-file-name buffer-file-name)) \"figure-\") \".png\") :exports both :width 600 :height 400 :session *R* \n\n#+end_src" "<src lang=\"R\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("p" "#+begin_src python :results output :exports both\n\n#+end_src" "<src lang=\"python\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("P" "#+begin_src python :results output :session *python* :exports both\n\n#+end_src" "<src lang=\"python\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("b" "#+begin_src shell :results output :exports both\n\n#+end_src" "<src lang=\"sh\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("B" "#+begin_src shell :session *shell* :results output :exports both \n\n#+end_src" "<src lang=\"sh\">\n\n</src>"))

(add-to-list 'org-structure-template-alist
        '("g" "#+begin_src dot :results output graphics :file \"/tmp/graph.pdf\" :exports both
   digraph G {
      node [color=black,fillcolor=white,shape=rectangle,style=filled,fontname=\"Helvetica\"];
      A[label=\"A\"]
      B[label=\"B\"]
      A->B
   }\n#+end_src" "<src lang=\"dot\">\n\n</src>"))

(global-set-key (kbd "C-c S-t") 'org-babel-execute-subtree)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-display-inline-images)
(add-hook 'org-mode-hook 'org-babel-result-hide-all)

(unless (boundp 'org-latex-classes) (setq org-latex-classes nil))

(add-to-list 'org-latex-classes '("acm-proc-article-sp" "\\documentclass{acm_proc_article-sp}\n \[NO-DEFAULT-PACKAGES]\n \[EXTRA]\n  \\usepackage{graphicx}\n  \\usepackage{hyperref}"  ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}")                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")                       ("\\paragraph{%s}" . "\\paragraph*{%s}")                       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-to-pdf-process '("pdflatex -interaction nonstopmode -output-directory %o %f ; bibtex `basename %f | sed 's/\.tex//'` ; pdflatex -interaction nonstopmode -output-directory  %o %f ; pdflatex -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'org-latex-classes '("article" "\\documentclass{article}\n \[NO-DEFAULT-PACKAGES]\n \[EXTRA]\n  \\usepackage{graphicx}\n  \\usepackage{hyperref}"  ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}")                       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")                       ("\\paragraph{%s}" . "\\paragraph*{%s}")                       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'auto-mode-alist '("\\.eml\\'" . org-mode))

(require 'tramp)
(setq tramp-default-method "scp")

(setq org-babel-python-command "python3")

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'monokai t)

(defun dotspacemacs/init ()
  (setq-default
    dotspacemacs-themes '(monokai)))


(cua-mode t)
    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
    (transient-mark-mode 1) ;; No region when it is not highlighted
    (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

(cua-mode 1)
(setq shift-select-mode t)

(delete-selection-mode)
